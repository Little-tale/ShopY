//
//  ShopModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

struct Shop: DTO {
    let total: Int
    let start: Int
    let display: Int
    let items: [ShopItem]
}
