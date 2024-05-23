//
//  UserDefaultManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation


enum UserDefaultManager {
    
    enum Key: String {
        case productId
        case searchHistory
    }
    
    @UserDefaultCodableWrapper(key: Key.productId.rawValue, placeValue: [])
    static var productId: Set<String>
    
    @UserDefaultWrapper(key: Key.searchHistory.rawValue, placeValue: [])
    static var searchHistory: Array<String>
}

