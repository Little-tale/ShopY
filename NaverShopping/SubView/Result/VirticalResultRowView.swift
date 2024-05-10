//
//  VirticalResultRowView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import SwiftUI

struct VirticalResultRowView: View {
    
    @Binding
    var model: ShopItem
    
    var body: some View {
        ZStack(alignment: .topTrailing, content: {
            ImageLoader().loadImage(from: model.imageProcess)
        })
    }
}


