//
//  ProfileModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift

final class ProfileRealmModel: Object, RealmFindType {
    
    typealias ID = String
    
    @Persisted(primaryKey: true) var profileId: ObjectId
    
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var introduce: String
    @Persisted var phoneNumber: String
    @Persisted var userImageUrl: String
    
    convenience
    init(name: String, phoneNumber: String, introduce:String, userImageUrl: String) {
        self.init()
        self.id = profileId.stringValue
        self.name = name
        self.introduce = introduce
        self.phoneNumber = phoneNumber
        self.userImageUrl = userImageUrl
    }
    
}
