//
//  ShopModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

struct Shop: Decodable {
    let total, start, display: Int
    let items: [ShopItem]
}

struct ShopItem: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice: String
    let mallName: String
    let productId: String
    
    var mallNameProcess: String {
        return mallName + " 판매자"
    }
    
    var priceProcess: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let data = numberFormatter.string(for: Int(lprice))
        
        guard let data = data else {
            return " 원"
        }
        return data + "원"
    }
    
    var imageProcess: URL?{
        return URL(string: image)
    }
    
    var productNameProcess: String {
        let first = title.replacingOccurrences(of: "<b>", with: "")
        let results = first.replacingOccurrences(of: "</b>", with: "")
        return results
    }

    var productIdProcess: Int{
        guard let productId = Int(productId) else {
            return 0
        }
        return productId
    }
    
}
