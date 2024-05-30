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
        
        var caseType: UserDefaultCase {
            switch self {
            case .productId:
                return .none
            case .searchHistory:
                return .recentry
            }
        }
    }
    
    @UserDefaultCodableWrapper(key: Key.productId.rawValue, placeValue: [])
    static var productId: Set<String>
    
    @UserDefaultWrapper(key: Key.searchHistory.rawValue, placeValue: [], ofCase: Key.searchHistory.caseType)
    static var searchHistory: Array<String>
    
    
    static func removeDeplicate(_ array: [String]) -> [String] {
        var seen = Set<String> ()// 중복 제거하기위함.
        return array.filter { seen.insert($0).inserted }
        // inserted -> Bool 값을 방출 만약 존재하는게 또 있다면, false
    }
    
}

