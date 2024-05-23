//
//  ShopItemModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation

struct ShopItemModel: EntityType, Hashable, Identifiable {
    
    var id: UUID
    
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: String
    
    var likeState = false
    var currentTag: Int = 0

    
    
    static func create(entity: ShopItemModel) {
        //
    }
    
    static func read(id: UUID) -> ShopItemModel? {
        return nil
    }
    
    static func update(entity: ShopItemModel) {
        //
    }
    
    static func delete(id: UUID) {
        //
    }
    
}

