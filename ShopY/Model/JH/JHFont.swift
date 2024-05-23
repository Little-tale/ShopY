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
        if #available(iOS 16.0, *) {
            return .system(.callout, design: .rounded, weight: .regular)
        } else {
            return .system(size: 16, weight: .regular, design: .rounded)
        }
    }
    
}

