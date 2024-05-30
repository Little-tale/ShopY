//
//  UserDefaultWrapper.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

enum UserDefaultCase {
    case none
    case recentry
}

@propertyWrapper
struct UserDefaultCodableWrapper<T: Codable> {
    
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

@propertyWrapper
struct UserDefaultWrapper<T> {
    let key: String
    let placeValue: T
    
    let ofCase: UserDefaultCase
    
    private
    let US = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            US.object(forKey: key) as? T ?? placeValue
        }
        set {
            if case .recentry = ofCase {
                guard let texts = newValue as? [String] else {
                    return
                }
                let result = UserDefaultManager.removeDeplicate(texts)
                print("해당 \(result)")
                US.setValue(result, forKey: key)
            } else {
                US.setValue(newValue, forKey: key)
            }
        }
    }
}
