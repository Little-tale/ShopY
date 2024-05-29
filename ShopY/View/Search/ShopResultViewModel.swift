//
//  ShopResultViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import Foundation

final class ShopResultViewModel: MVIPatternType {
    
    enum Intent {
        case startModel(ShopEntityModel)
        case changedState
    }
    
    struct StateModel {
        var likeState = false
        var navTititle = ""
        var ifError = false
        var realmError: RealmError?
        
        var currentModel: ShopEntityModel?
    }
    
    @Published
    var stateModel = StateModel()
    
    private
    let repository = ShopItemsRepository()
}

extension ShopResultViewModel {
    
    func send(_ action: Intent) {
        switch action {
        case .startModel(let model):
            proceccingModel(model: model)
        case .changedState:
            changedState()
        }
    }
}

extension ShopResultViewModel {
    
    private
    func proceccingModel(model: ShopEntityModel) {
        stateModel.likeState = model.likeState
        stateModel.navTititle = model.title
        stateModel.currentModel = model
    }
    
    private
    func changedState() {
        guard var model = stateModel.currentModel else { return }
        let result = repository.likeRegOrDel(model)
        
        if case .failure(let failure) = result {
            stateModel.realmError = failure
        }
        
        model.likeState = !model.likeState
       
        stateModel.likeState = model.likeState
        stateModel.currentModel = model
    }
}
