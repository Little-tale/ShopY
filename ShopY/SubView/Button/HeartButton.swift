//
//  HeartButton.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

struct HeartButton: View {
    
    @Binding
    var isSelected: Bool
    
    let tag: Int?
    
    let clear: Bool
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button (action: action) {
                Image(systemName: isSelected ? "heart.fill" : "heart" )
                    .foregroundStyle(.red)
            }
            .padding(.all, 8)
            .background(
                Color(clear ? .clear : .onlyWhite)
            )
            .clipShape(Circle(), style: FillStyle())
        }
        .tag(tag)
    }
}
