//
//  RootViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation
import Combine

final class NavigationManager: MVIPatternType{
    
    private
    let realmRepository = RealmRepository()
    
    private
    let networkMonitor = NetworkMonitorManager.shared
    
    private
    var cancelable = Set<AnyCancellable> ()
    
    @Published
    var stateModel = StateModel()
    
    enum Intent {
        case viewOnAppear
        case ifUserInfoReg
        case hideTabbar
        case showTabbar
        case showSearchView
    }
    
    struct StateModel {
        var currentRoot: Roots = .splash
        var error = errorTypes.noneError
        var alertTrigger = false
        var tabbarisHidden = false
        var gosearchView = false
    }
    
    enum Roots {
        case splash
        case startView
        case tabbarView
    }
    
    enum errorTypes: ErrorMessageType {
        case noneError
        case realmError(RealmError)
        case retainCycleError
        case networkStatusError
        
        var message: String {
            return switch self {
            case .noneError:
                ""
            case .realmError(let realmError):
                realmError.message
            case .retainCycleError:
                "내부의 치명적인 이슈가 발생했습니다."
            case .networkStatusError:
                "사용자의 네트워크 상태를 확인하여 주세요"
            }
        }
    }
    
    init() {
        networkMonitor.currentNetworkState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] type in
                guard let weakSelf = self else {
                    self?.stateModel.error = .retainCycleError
                    self?.stateModel.alertTrigger = true
                    return
                }
                switch type {
                case .connected:
                    break
                case .deConnected, .unknown:
                    weakSelf.stateModel.error = .networkStatusError
                    weakSelf.stateModel.alertTrigger = true
                }
            }
            .store(in: &cancelable)
    }
    
}


extension NavigationManager {
    
    func send(_ action: Intent) {
        switch action {
        case .viewOnAppear:
            transFormToViewOnApear()
            networkMonitor.startMonitor()
        case .ifUserInfoReg:
            transFormToViewOnApear()
        case .hideTabbar:
            print("Tabbar Hidden Acting")
            stateModel.tabbarisHidden = true
        case .showTabbar:
            print("Tabbar Show Acting")
            stateModel.tabbarisHidden = false
        case .showSearchView:
            stateModel.gosearchView.toggle()
        }
    }
}

extension NavigationManager {
    func transFormToViewOnApear() {
        let result = realmRepository.fetchAll(type: ProfileRealmModel.self)
        
        switch result {
        case .success(let model):
            let array = Array(model)
            
            if array.isEmpty {
                stateModel.currentRoot = .startView
            } else {
                stateModel.currentRoot = .tabbarView
            }
        case .failure(let error):
            stateModel.error = .realmError(error)
            stateModel.alertTrigger.toggle()
        }
    }
}
