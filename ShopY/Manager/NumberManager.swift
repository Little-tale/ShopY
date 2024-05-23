//
//  NumberManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation

final class NumberManager {
    
    private init () { }
    
    static let shared = NumberManager()
    
    
    private lazy var dicimalNumberFormatter = NumberFormatter().Interfaced {
        $0.numberStyle = .decimal
    }
}

// MARK: Processing
extension NumberManager {
    
    func dicimalicStringToString(with num: String) -> String? {
        
        guard let ifInt = Int(num) else {
            return nil
        }
        
        return dicimalNumberFormatter.string(
            from: NSNumber(value: ifInt)
        )
    }
}

