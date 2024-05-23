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
            title: productNameProcess(productName: dto.title),
            link: dto.link,
            image: imageProcess(url: dto.image),
            lprice: priceProcess(price: dto.lprice),
            hprice: priceProcess(price: dto.hprice),
            mallName: mallNameProcess(mallName: dto.mallName),
            productId: productIdProcess(productId: dto.productId)
        )
    }
    
    private
    func priceProcess(price: String) -> String {
        let data = NumberManager.shared.dicimalicStringToString(with: price)
        
        guard let data = data else {
            return " 원"
        }
        return data + "원"
    }
    
    private
    func imageProcess(url: String) -> URL?{
        return URL(string: url)
    }
    
    private
    func productNameProcess(productName: String) -> String {
        let first = productName.replacingOccurrences(of: "<b>", with: "")
        let results = first.replacingOccurrences(of: "</b>", with: "")
        return results
    }

    private
    func productIdProcess(productId: String) -> Int{
        guard let productId = Int(productId) else {
            return 0
        }
        return productId
    }

    private
    func mallNameProcess(mallName: String) -> String {
        return mallName + " 판매자"
    }
}
