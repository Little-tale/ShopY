//
//  LikeViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import Foundation

final class LikeViewModel: MVIPatternType {
    enum errorCase {
        case none
        case realm(RealmError)
        
        var message: String {
            switch self {
            case .none:
                return ""
            case .realm(let realmError):
                return realmError.message
            }
        }
    }
    
    enum Intent {
        case onAppear
        case likeStateChange(ShopEntityModel, Int)
        case onTapModel(ShopEntityModel, Int)
    }
    
    struct StateModel {
        var currentLikes: [ShopEntityModel] = []
        var ifError: Bool = false
        var error: errorCase = .none
        var moveModel: (ShopEntityModel, Int)? = nil
        
        var moveToWebView: Bool = false
        
    }
    
    @Published
    var stateModel = StateModel()
    
    private
    let shopItemsRepository = ShopItemsRepository()
    
}

extension LikeViewModel {
    func send(_ action: Intent) {
        switch action {
        case .onAppear:
            startModel()
        case .likeStateChange(let model, let at):
            break
        case .onTapModel(let model, let at):
            stateModel.moveModel = (model, at)
            stateModel.moveToWebView.toggle()
        }
    }
}

extension LikeViewModel {
    private
    func startModel(){
        shopItemsRepository.getLikeModels {[weak self] result in
            switch result {
            case .success(let models):
                self?.stateModel.currentLikes = models
            case .failure(let error):
                self?.stateModel.error = .realm(error)
            }
        }
    }
    
  
    
}
