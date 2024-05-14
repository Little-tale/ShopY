//
//  ProfileModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift

final class ProfileRealmModel: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String
    @Persisted var phoneNumber: String
    @Persisted var userImageUrl: String
    
    convenience
    init(name: String, phoneNumber: String, userImageUrl: String) {
        self.init()
        self.name = name
        self.phoneNumber = phoneNumber
        self.userImageUrl = userImageUrl
    }
    
}
