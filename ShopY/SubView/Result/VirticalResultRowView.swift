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
    var model: ShopEntityModel
    
    var heartButtonTapped: (ShopEntityModel) -> Void
    
    @State
    var likeState = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                ResultImageView(url: model.imageProcess)
                HeartButton(
                    isSelected: $likeState,
                    tag: model.currentTag, clear: false) {
                        var before = model
                        before.likeState = !before.likeState
                        heartButtonTapped(before)
                        likeState.toggle()
                    }
                    .padding(.top, 2)
                    .padding(.trailing, 2)
            }
            Text(model.mallName)
                .font(.footnote)
            Text(model.title)
                .lineLimit(2)
                .font(.subheadline)
                .padding(.bottom, 4)
                .frame(height: 50)
            
            Text(model.lprice)
                .lineLimit(1)
        }
        
        .onAppear {
            likeState = model.likeState
            print("토글 상태",model.likeState)
        }
        
    }
}


struct ResultImageView: View {
    let url: URL?
    
    var body: some View {
        DownSamplingImageView(url: url)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 1)
            }
    }
}

