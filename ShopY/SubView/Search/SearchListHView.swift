//
//  SearchListHView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

struct SearchListHView: View {
    
    let text: String
    let xButtonTap: () -> Void
    let tag: Int
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .frame(width: 20, height: 20)
                
            Text(text)
            Spacer()
            Image(systemName: "xmark")
                .asButton(action: xButtonTap)
                .tag(tag)
        }
    }
}


