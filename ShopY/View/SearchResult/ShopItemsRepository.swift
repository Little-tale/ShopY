//
//  SearchResultRepository.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation
import Combine

final class ShopItemsRepository {
    
    private
    let shopMapper = ShopEntityMapper()
    
    private
    let repository = RealmRepository()
    
}

extension ShopItemsRepository {
    
    func requestPost(
        search: String,
        next: Int,
        sort: SortCase
    ) -> AnyPublisher<(total:Int, models:[ShopEntityModel]),NetworkError>
    {
        let query = SearchQueryItems(
            searchText: search,
            display: Const.NaverAPi.display,
            start: next,
            sort: sort.rawValue
        )
        print(query)
        return NetworkManager.fetchNetwork(
            model: ShopDTOModlel.self,
            router: .search(query: query)
        )
         .compactMap { [weak self] model in
             return self?.shopMapper.toEntity(dtoP: model)
         }
         .receive(on: DispatchQueue.main)
         .compactMap{ [weak self] (total, models) in
             var models = models.compactMap {
                 self?.ifLikeModel(model: $0)
             }
             return (total: total, models: models)
         }
         .eraseToAnyPublisher()
    }
}

// MARK: CRUD
extension ShopItemsRepository {
    
    func likeRegOrDel(_ model: ShopEntityModel) ->  Result<Void, RealmError> {
        
        guard case .success(let ifModel) = repository.findById(
            type: LikePostModel.self,
            id: model.productId
        ) else {
            return .failure(.cantFindModel)
        }
        
        if ifModel == nil {
            
            let like = LikePostModel(
                postId: model.productId,
                title: model.title,
                sellerName: model.mallName,
                postImageUrlString: model.image,
                postURLString: model.link,
                lprice: model.lprice
            )
            let result = repository.add(like)
            switch result {
            case .success:
                return .success(())
            case .failure(let failure):
                return .failure(failure)
            }
            
        } else {
            let result = repository.findIDAndRemove(
                type: LikePostModel.self,
                id: model.productId
            )
            
            switch result {
            case .success(let void):
                return .success(void)
            case .failure(let failure):
                return .failure(failure)
            }
        }
    }
    
    private
    func ifLikeModel(model: ShopEntityModel) -> ShopEntityModel {
        var model = model
        let result = repository.findById(
           type: LikePostModel.self,
           id: model.productId
        )
        
        switch result {
        case .success(let ifLike):
            if ifLike != nil {
                model.likeState = true
            } else {
                model.likeState = false
            }
            return model
        case .failure:
            return model
        }
    }
    
    
    func getLikeModels(complite: @escaping(Result<[ShopEntityModel], RealmError>) -> Void) {
        let result = repository.fetchAll(type: LikePostModel.self)
            
        switch result {
        case .success(let models):
            let array = Array(models)
            let result = shopMapper.toEntity(Array(models))
            let resultLike = result.map { model in
                var model = model
                model.likeState = true
                return model
            }
            complite(.success(resultLike))
        case .failure(let error):
            complite(.failure(error))
        }
        
    }
}
