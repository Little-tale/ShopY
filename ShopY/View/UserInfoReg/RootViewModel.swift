//
//  RootViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation
import Combine

final class RootViewModel: MVIPatternType{
    
    private
    let realmRepository = RealmRepository()
    
    private
    let cancelable = Set<AnyCancellable> ()
    
    @Published
    var stateModel = StateModel()
    
    enum Intent {
        case viewOnAppear
        case ifUserInfoReg
        case hideTabbar
        case showTabbar
    }
    
    struct StateModel {
        var currentRoot: Roots = .splash
        var error = errorTypes.noneError
        var alertTrigger = false
        var tabbarisHidden = false
    }
    
    enum Roots {
        case splash
        case startView
        case tabbarView
    }
    
    enum errorTypes: ErrorMessageType {
        case noneError
        case realmError(RealmError)
        
        var message: String {
            return switch self {
            case .noneError:
                ""
            case .realmError(let realmError):
                realmError.message
            }
        }
    }
    
}


extension RootViewModel {
    
    func send(action: Intent){
        switch action {
        case .viewOnAppear:
            transFormToViewOnApear()
        case .ifUserInfoReg:
            transFormToViewOnApear()
        case .hideTabbar:
            print("와이")
            stateModel.tabbarisHidden = true
        case .showTabbar:
            stateModel.tabbarisHidden = false
        }
    }
}

extension RootViewModel {
    func transFormToViewOnApear() {
        let result = realmRepository.fetchAll(type: ProfileRealmModel.self)
        
        switch result {
        case .success(let model):
            let array = Array(model)
            print("???",array)
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
