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
                ResultImageView(url: model.imageProcess)
                HeartButton(
                    isSelected: $model.likeState,
                    tag: model.currentTag) {
                        var before = model
                        before.likeState = !before.likeState
                        heartButtonTapped(before)
                        

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
            Spacer()
            Text(model.priceProcess)
        }
        .onAppear {
            print("토글전",model.likeState)
        }
    }
}


struct ResultImageView: View {
    let url: URL?
    
    var body: some View {
        DownSamplingImageView(url: url)
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 1)
            }
    }
}

