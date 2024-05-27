//
//  ShopEntityModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation


struct ShopEntityModel: Hashable, Equatable{
    
    let productId: String
    
    let title: String
    let link: String
    let image: String
    let lprice, hprice: String
    let mallName: String
    
    var likeState = false
    var currentTag: Int = 0
    
    var imageProcess: URL? {
        return URL(string: image)
    }

    var productIdProcess: Int {
        guard let productId = Int(productId) else {
            return 0
        }
        return productId
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.productId == rhs.productId && lhs.likeState == rhs.likeState {
            return true
        } else {
            return false 
        }
    }
}

