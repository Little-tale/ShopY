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
}
