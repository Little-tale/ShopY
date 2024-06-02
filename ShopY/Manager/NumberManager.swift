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
        case total = " 개의 검색 결과"
    }
    
    static let shared = NumberManager()
    
    private init () {} 
}

extension NumberManager {
    
    func getTextToDecimal(unitCase: UnitCase, text: String) -> String {
        formatter.numberStyle = .decimal
        
        let numberString = formatter.string(for: Int(text))
        
        if let numberString {
            return numberString + unitCase.rawValue
        } else {
            return UnitCase.money.rawValue
        }
    }
}
