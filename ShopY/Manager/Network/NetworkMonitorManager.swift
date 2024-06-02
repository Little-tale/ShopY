//
//  NetworkMonitorManager.swift
//  ShopY
//
//  Created by Jae hyung Kim on 6/2/24.
//

import Network
import Foundation
import Combine

final class NetworkMonitorManager {
    
    enum ConnectionType {
        case startAndWait
        case cellular
        case ethernet
        case unknown
        case wifi
    }
    
    enum NetworkState {
        case connected
        case deConnected
        case unknown
    }
    
    static let shared = NetworkMonitorManager()
    
    private let monitor: NWPathMonitor
    
    private let queue: DispatchQueue
    
    let currentNetworkType = CurrentValueSubject<NetworkMonitorManager.ConnectionType, Never> (.startAndWait)
    
    let currentNetworkState = CurrentValueSubject<NetworkState, Never> (.connected)
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
    }
}


extension NetworkMonitorManager {
    
    func startMonitor() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [unowned self] nwpath in
            
            checkNetworkStatus(path: nwpath.status)
            
            checkNetworkType(nwPath: nwpath)
        }
    }
    
    func stopMonitor() {
        monitor.cancel()
        currentNetworkType.send(.startAndWait)
    }
}


extension NetworkMonitorManager {
    
    private func checkNetworkStatus(path: NWPath.Status) {
        
        switch path {
        case .satisfied:
            currentNetworkState.send(.connected)
            
        case .unsatisfied, .requiresConnection:
            currentNetworkState.send(.deConnected)
            
        @unknown default:
            currentNetworkState.send(.unknown)
        }
    }
    
    private func checkNetworkType(nwPath: NWPath) {
        
        if nwPath.usesInterfaceType(.wifi){
            currentNetworkType.send(.wifi)
        } else if nwPath.usesInterfaceType(.cellular){
            currentNetworkType.send(.cellular)
        } else if nwPath.usesInterfaceType(.wiredEthernet){
            currentNetworkType.send(.ethernet)
        } else {
            currentNetworkType.send(.unknown)
        }
    }
}
