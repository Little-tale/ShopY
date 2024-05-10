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
    
    @Binding
    var isModelLike: Bool
    
    var heartButtonTapped: (Int) -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing, content: {
                CustomLazyImage(imageURL: model.imageProcess)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
                
                HeartButton(
                    isSelected: $isModelLike,
                    tag: model.currentTag) {
                        heartButtonTapped(model.currentTag)
                    }
            })
            Text(model.mallNameProcess)
            Text(model.productNameProcess)
            Text(model.priceProcess)
        }
    }
}


