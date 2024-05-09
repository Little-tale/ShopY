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
    
    let tag: Int
    
    let action: () -> Void
    
    var body: some View {
        
        Button (action: action) {
            Image(systemName: isSelected ? "heart.fill" : "heart" )
                .foregroundStyle(.red)
        }
        .padding(.all, 8)
        .background(
            .white
        )
        .clipShape(Circle(), style: FillStyle())
       
        .tag(tag)
    }
}
