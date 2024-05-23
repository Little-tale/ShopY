//
//  ShopItemMapper.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation

struct ShopItemMapper {
    
    func toEntity(_ dto: ShopItem) -> ShopItemModel {
        
        return ShopItemModel(
            id: <#T##UUID#>,
            title: <#T##String#>,
            link: <#T##String#>,
            image: <#T##String#>,
            lprice: <#T##String#>,
            hprice: <#T##String#>,
            mallName: <#T##String#>,
            productId: <#T##String#>
        )
    }
    
    func priceProcess(price: String) -> String {
        let data = NumberManager.shared.dicimalicStringToString(with: price)
        
        guard let data = data else {
            return " 원"
        }
        return data + "원"
    }

    func imageProcess(url: String) -> URL?{
        return URL(string: url)
    }

    func productNameProcess(productName: String) -> String {
        let first = productName.replacingOccurrences(of: "<b>", with: "")
        let results = first.replacingOccurrences(of: "</b>", with: "")
        return results
    }

    func productIdProcess(productId: String) -> Int{
        guard let productId = Int(productId) else {
            return 0
        }
        return productId
    }

    var mallNameProcess: String {
        return mallName + " 판매자"
    }
}
