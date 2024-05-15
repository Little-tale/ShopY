//
//  CircleProfileImage.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import SwiftUI

struct CircularProfileImage: ViewModifier {
   
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient (
                        colors: [JHColor.likeColor, JHColor.pointGreen],
                        startPoint: .leading,
                        endPoint: .bottom
                    )
                )
            }
    }
}
