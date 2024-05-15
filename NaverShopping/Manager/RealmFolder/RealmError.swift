//
//  RealmError.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation

enum RealmError: Error {
    case cantLoadRealm
    case failAdd
    case failRemove
    case cantFindModel
}
