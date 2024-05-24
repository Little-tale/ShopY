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
    ) -> AnyPublisher<[ShopEntityModel],NetworkError> 
    {
        let query = SearchQueryItems(
            searchText: search,
            display: Const.NaverAPi.display,
            start: next,
            sort: sort.name
        )
        
        return NetworkManager.fetchNetwork(
            model: ShopDTOModlel.self,
            router: .search(query: query)
        )
         .compactMap { [weak self] in
             self?.shopMapper.toEntity($0.items)
         }
         .eraseToAnyPublisher()
    }
    
}
