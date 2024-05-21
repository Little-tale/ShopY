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
    }
    
    struct StateModel {
        var currentRoot: Roots = .splash
        var error = errorTypes.noneError
        var alertTrigger = false
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
        }
    }
}

extension RootViewModel {
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
