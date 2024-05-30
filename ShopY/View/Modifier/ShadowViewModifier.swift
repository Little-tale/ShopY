//
//  ShadowViewModifier.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/30/24.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [
                        JHColor.black.opacity(0),
                        JHColor.black.opacity(0.5),
                        JHColor.black.opacity(0.7),
                        JHColor.black.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}
