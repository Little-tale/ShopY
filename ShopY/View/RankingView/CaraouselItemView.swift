//
//  CaraouselItemView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/30/24.
//

import SwiftUI

struct CaraouselItemView: View {
    
    let item: ShopEntityModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                
                DownSamplingImageView(
                    url: URL(string: item.image),
                    size: CGSize(width: UIScreen.main.bounds.width, height: 100)
                )
                .modifier(cornerRadiusVersion(cornerRadius: 8))
                
                HStack {
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .padding()
                            .lineLimit(2)
                            .font(
                                .system(
                                    size: 20,
                                    weight: .bold,
                                    design: .default
                                )
                            )
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(item.lprice)
                            .font(JHFont.largePrice)
                            .foregroundStyle(JHColor.likeColor)
                    }
                    .padding(.trailing, 12)
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .foregroundStyle(JHColor.white)
                .modifier(ShadowModifier())
            }
            
        }
    }
}
