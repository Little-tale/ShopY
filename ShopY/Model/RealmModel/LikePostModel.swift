//
//  LikePostModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift


final class LikePostModel: Object, RealmFindType {
    
    typealias ID = String
    
    @Persisted(primaryKey: true) var id: String
    
    @Persisted var title: String
    @Persisted var sellerName: String
    @Persisted var postUrlString: String
    
    convenience
    init(postId: String, title: String, sellerName: String, postUrlString: String) {
        self.init()
        self.id = postId
        self.title = title
        self.sellerName = sellerName
        self.postUrlString = postUrlString
    }

}
