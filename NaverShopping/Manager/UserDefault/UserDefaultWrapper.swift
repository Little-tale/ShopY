//
//  UserDefaultWrapper.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation


struct UserDefaultWrapper<T> {
    let key: String
    let placeValue: T
    
    private
    let US = UserDefaults.standard
    
    var wrapperValue: T {
        get {
            US.object(forKey: key) as? T ?? placeValue
        }
        set {
            US.setValue(newValue, forKey: key)
        }
    }
    
}
