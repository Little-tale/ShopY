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
                    .stroke(LinearGradient(gradient: Gradient(colors: [.backDarkGray, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5)
            )
        }
    }
}
