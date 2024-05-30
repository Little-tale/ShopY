//
//  JHFont.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import SwiftUI

enum JHFont { }

extension JHFont {
    
   
    static var startFont: Font {
        return .system(size: 19, weight: .regular, design: .rounded)
    }
    
    static var profileNameFont: Font {
        if #available(iOS 16.0, *) {
            return .system(.headline)
        } else {
            return .system(size: 18, weight: .bold, design: .monospaced)
        }
    }
    
    static var introduceFont: Font {
        if #available(iOS 16.0, *) {
            return .system(.caption)
        } else {
            return .system(size: 12, weight: .regular, design: .monospaced)
        }
    }
    
    
    static var appNameFont: Font {
        return .system(size: 60, weight: .bold, design: .default)
    }
    
    static var appIntroduceFont: Font {
        return .system(size: 20, weight: .medium, design: .default)
    }
    
    static var largePrice: Font {
        return .system(size: 28, weight: .bold, design: .serif)
    }
    
}

