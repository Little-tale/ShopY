//
//  ShopDTOModlel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

// 네이버 쇼핑 중앙 모델
struct ShopDTOModlel: DTOType {
    let total, start, display: Int
    let items: [ShopItem]
}
