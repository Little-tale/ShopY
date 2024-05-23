//
//  ShopItemModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation

struct ShopItemModel:  Hashable, Identifiable {
    
    var id = UUID()

    let title: String
    let link: String
    let image: URL?
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: Int
    
    var likeState = false
    var currentTag: Int = 0
}

