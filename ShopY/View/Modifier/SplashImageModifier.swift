//
//  SplashImageModifier.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/11/24.
//

import SwiftUI

struct SplashImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 200, height: 200, alignment: .center)
            .padding(.horizontal, 60)
    }
}
