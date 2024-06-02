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
    
    static let shared = NetworkMonitorManager()
    
    private let monitor: NWPathMonitor
    
    private let queue: DispatchQueue
    
    let currentNetworkState = CurrentValueSubject<NetworkMonitorManager.ConnectionType, Never> (.startAndWait)
    
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
    }
}


extension NetworkMonitorManager {
    
    func startMonitor() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [unowned self] nwpath in
            if nwpath.usesInterfaceType(.wifi){
                currentNetworkState.send(.wifi)
            } else if nwpath.usesInterfaceType(.cellular){
                currentNetworkState.send(.cellular)
            } else if nwpath.usesInterfaceType(.wiredEthernet){
                currentNetworkState.send(.ethernet)
            } else {
                currentNetworkState.send(.unknown)
            }
        }
    }
    
    func stopMonitor() {
        monitor.cancel()
        currentNetworkState.send(.startAndWait)
    }
}
