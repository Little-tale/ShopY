//
//  CircleProfileImage.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import SwiftUI

struct CircularProfileImage: ViewModifier {
    
    var frame: CGSize
   
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: frame.width, height: frame.height)
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
