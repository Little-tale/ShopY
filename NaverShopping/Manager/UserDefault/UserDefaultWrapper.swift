//
//  UserDefaultWrapper.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    
    let key: String
    let placeValue: T
    
    private
    let US = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            guard let data = US.data(forKey: key),
                  let value = try? JSONDecoder().decode(T.self, from: data) else {
                return placeValue
            }
            return value
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            US.setValue(data, forKey: key)
        }
    }
    
}
