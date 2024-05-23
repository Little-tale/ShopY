//
//  WarningTextViewModifier.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/17/24.
//

import SwiftUI

struct WarningTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(JHColor.warningColor)
    }
    
}
