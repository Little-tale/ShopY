//
//  TextValidTestManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/17/24.
//

import Foundation

struct TextValidTestManager {
    
    enum TextValidCase {
        case userName(text: String)
        case phoneNumber(text: String)
        
        var pattarn: String {
            return switch self {
            case .userName:
                "^[가-힣A-Za-z0-9]{2,6}$"
            case .phoneNumber:
                "^(?:\\d{9,13}|)$"
            }
        }
    }
    
    static
    func matchesPattern(_ validcase: TextValidCase) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: validcase.pattarn)
    
            switch validcase {
            case .userName(let text),
                .phoneNumber(let text):
                
                let range = NSRange(location: 0, length: text.utf16.count)
                
                if regex.firstMatch(in: text, options: [], range: range) != nil {
                    return true
                }
                return false
            }
            
        } catch {
            return false
        }
        
        
    }
    
    
}
