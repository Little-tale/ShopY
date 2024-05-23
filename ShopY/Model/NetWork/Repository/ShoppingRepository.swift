//
//  ShoppingRepository.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

final class ShoppingRepository {
    
    private
    let mapper = ShopItemMapper()
    
    private
    let network = NetworkManager()
    
}

extension ShoppingRepository {
    
    func getFetch(title: String,
                  display: Int,
                  start: Int,
                  sort: String
    ) {
        
        let query = SearchQueryItems(
            searchText: title,
            display: display,
            start: start,
            sort: sort
        )
        
        let test = NetworkManager.fetchNetwork(
            model: Shop.self,
            router: .search(query: query)
        )
            .map { $0.items.map { [weak self] in self?.mapper.toEntity($0) } }
            .compactMap { $0 }
    }
}
