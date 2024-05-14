//
//  LikePostModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift
/*
 좋아요를 유저 디폴트로 해보았으니
 렘으로 옮겨보고 위젯도 만들어 보고 하겠습니다.
 
 렘을 실시간 변동을 감지해서 데이터를 반영해야 하는데.
 */

final class LikePostModel: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var title: String
    @Persisted var sellerName: String
    @Persisted var postUrlString: String
    
    convenience
    init(title: String, sellerName: String, postUrlString: String) {
        self.init()
        self.title = title
        self.sellerName = sellerName
        self.postUrlString = postUrlString
    }

}
