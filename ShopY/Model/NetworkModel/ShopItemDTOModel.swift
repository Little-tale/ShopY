//
//  ShopItemDTOModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

struct ShopItemDTOModel: DTOType {
    let title: String
    let link: String
    let image: String
    let lprice, hprice: String
    let mallName: String
    let productId: String
    
    enum CodingKeys: CodingKey {
        case title
        case link
        case image
        case lprice
        case hprice
        case mallName
        case productId
    }
    
    init(title: String, link: String, image: String, lprice: String, hprice: String, mallName: String, productId: String) {
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.hprice = hprice
        self.mallName = mallName
        self.productId = productId
    }
}
