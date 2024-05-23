//
//  HTTPMethod.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation


struct HTTPMethod {
    
    static let get = HTTPMethod(rawValue: "GET")
    
    static let post = HTTPMethod(rawValue: "POST")
    
    static let Put = HTTPMethod(rawValue: "PUT")
    
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

