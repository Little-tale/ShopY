//
//  VirticalResultRowView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import SwiftUI
import Kingfisher
/*
 Invalid frame dimension (negative or non-finite).
 */

struct VirticalResultRowView: View {
    
    @Binding
    var model: ShopItem
    
    @State
    var isModelLike: Bool = false
    
    var heartButtonTapped: (ShopItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing, content: {
                DownSamplingImageView(url: model.imageProcess)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipShape(.rect(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 1)
                    }
                HeartButton(
                    isSelected: $isModelLike,
                    tag: model.currentTag) {
                        heartButtonTapped(model)
                    }
                    .padding(.top, 2)
                    .padding(.trailing, 2)
            })
            
            Text(model.mallNameProcess)
                .font(.footnote)
            Text(model.productNameProcess)
                .lineLimit(2)
                .font(.subheadline)
                .padding(.bottom, 4)
            Text(model.priceProcess)
        }
    }
}


