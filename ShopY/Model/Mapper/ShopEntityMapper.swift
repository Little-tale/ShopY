//
//  ShopEntity.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

struct ShopEntityMapper {
    
    func toEntity(_ dto: ShopItemDTOModel) -> ShopEntityModel? {
        
        let entity = ShopEntityModel(
            productId: dto.productId,
            title: dto.title.rmHTMLTag,
            link: shoppingURLProcess(
                productID: dto.productId
            ),
            image: dto.image,
            lprice: NumberManager.shared.getTextToMoney(text: dto.lprice),
            hprice: dto.hprice,
            mallName: mallNameProcess(name: dto.mallName)
        )
        
        return entity
    }
    
    func toEntity(_ likeModel: LikePostModel) -> ShopEntityModel {
        return ShopEntityModel(
            productId: likeModel.id,
            title: likeModel.title,
            link: likeModel.postURLString,
            image: likeModel.postImageUrlString,
            lprice: likeModel.lPrice,
            hprice: "",
            mallName: likeModel.sellerName
        )
    }
}

extension ShopEntityMapper {
    
    func toEntity(_ dtos: [ShopItemDTOModel]) -> [ShopEntityModel] {
        
        return dtos.compactMap { toEntity($0) }
    }
    
    func toEntity(dtoP: ShopDTOModlel) -> (total: Int, [ShopEntityModel]) {
        
        return (dtoP.total, dtoP.items.compactMap({ toEntity($0) }))
    }
}

extension ShopEntityMapper {
    
    func toEntity(_ realmModels: [LikePostModel]) -> [ShopEntityModel] {
        return realmModels.compactMap { toEntity($0) }
    }
    
}

extension ShopEntityMapper {
    
    private
    func mallNameProcess(name: String) -> String {
        return name + " 판매자"
    }
    
    private
    func shoppingURLProcess(productID: String) -> String{
        let base = APIKey.naverShopProductBase
        guard let url = URL(string:base + productID) else {
            print("실패...")
            return ""
        }
        return url.absoluteString
    }
}
