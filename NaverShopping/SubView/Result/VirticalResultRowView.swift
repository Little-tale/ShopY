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
                    isSelected: $model.likeState,
                    tag: model.currentTag) {
                        var before = model
                        before.likeState = !before.likeState
                        heartButtonTapped(before)
                        
                        if before.likeState {
                            print("좋아요 \(before.productNameProcess)")
                            UserDefaultManager.productId.insert(before.productId)
                        } else {
                            print("좋아요취소 \(before.productNameProcess)")
                            UserDefaultManager.productId.remove(before.productId)
                        }
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
        .onAppear {
            print("토글전",model.likeState)
        }
    }
}


