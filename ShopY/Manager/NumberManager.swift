//
//  NumberFormatter.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

struct NumberManager {
    private let formatter = NumberFormatter()
    
    enum UnitCase: String {
        case money = " 원"
    }
    
    static let shared = NumberManager()
    
}

extension NumberManager {
    
    func getTextToMoney(text: String) -> String {
        formatter.numberStyle = .decimal
        
        let numberString = formatter.string(for: Int(text))
        
        if let numberString {
            return numberString + UnitCase.money.rawValue
        } else {
            return UnitCase.money.rawValue
        }
    }
}
