//
//  ShopItem.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation


struct ShopItem: Decodable{
   
    let title: String
    let link: String
    let image: String
    let lprice, hprice: String
    let mallName: String
    let productId: String

}

/* // 엔티티에 들어갈 프로퍼티
 Hashable, Identifiable
 
 var id = UUID()
 
 var likeState = false
 var currentTag: Int = 0
 
 // 엔티티에 필요한 메서드
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
 
 var mallNameProcess: String {
     return mallName + " 판매자"
 }
 */
