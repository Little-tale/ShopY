//
//  UserDefaultWrapper.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T> {
    
    let key: String
    let placeValue: T
    
    private
    let US = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            US.object(forKey: key) as? T ?? placeValue
        }
        set {
            US.setValue(newValue, forKey: key)
        }
    }
    
}
