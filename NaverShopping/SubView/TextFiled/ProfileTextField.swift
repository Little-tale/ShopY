//
//  ProfileTextField.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import SwiftUI

struct ProfileTextField: View {
    
    let headLine: String
    
    let placeHolder: String
    
    @Binding
    var text: String
    
    let state: Bool?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(headLine)
                .padding(.leading, 10)
                .foregroundStyle(.backDarkGray)
                .font(.system(size: 17, weight: .bold, design: .rounded))
            
            TextField(placeHolder, text: $text)
            .padding(.all, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2.5)
            )
        }
    }
    
    var borderColor: LinearGradient {
        let endColor = JHColor.darkGray
        var startColor = state == true ? JHColor.likeColor : JHColor.onlyDarkGray
        
        if state == nil {
            startColor = JHColor.likeColor
        }
        
        return LinearGradient(
            gradient: Gradient(colors: [startColor, endColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
}
