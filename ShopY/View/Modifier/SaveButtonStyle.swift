//
//  SaveButtonStyle.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/16/24.
//

import SwiftUI

struct SaveButtonStyle: ButtonStyle {
    
    let buttonState: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background( buttonState ? JHColor.likeColor : JHColor.gray)
            .foregroundStyle(buttonState ? JHColor.white : JHColor.darkGray)
            .clipShape(Capsule())
            .scaleEffect(buttonState ? (configuration.isPressed ? 0.8 : 1) : 1) 
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
