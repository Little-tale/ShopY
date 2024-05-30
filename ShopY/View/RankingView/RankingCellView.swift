//
//  RankingCellView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import SwiftUI


struct RankingCellView: View {
    
    private
    let size = CGSize(width: 100, height: 150)
    
    var ranking: Int
    let model: ShopEntityModel
    
    var body: some View {
        HStack (alignment:.bottom ,spacing: -8){
            Text("\(ranking)")
                .font(
                    .system(
                        size: 100,
                        weight: .bold,
                        design: .serif
                    )
                )
                .offset(y: 20)
            contentView
            .frame(width: size.width, height: size.height)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(JHColor.white)
                    .shadow(
                        color: JHColor.darkGray.opacity(0.5),
                        radius: 5,
                        x: 0,
                        y: 0
                    )
            )
        }
        
        
    }
}


extension RankingCellView {
    var contentView: some View {
        ZStack (alignment: .bottom) {
            DownSamplingImageView(url: URL(string: model.image), size: size)
                .background(JHColor.white)
            
            VStack(spacing: 0) {
                Text(model.title)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .lineLimit(1)
                Text(model.mallName)
                    .modifier(pointModifier(padding: 30, max: size.width))
            }
            .padding(.top, 10)
            .frame(width: size.width)
            .foregroundStyle(JHColor.white)
            .modifier(ShadowModifier())
            // V
        } // Z
    }
}

extension RankingCellView {
    
    struct pointModifier: ViewModifier {
        
        let padding: CGFloat
        let max: CGFloat
        
        func body(content: Content) -> some View {
            content
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .frame(maxWidth: .infinity)
                .background(JHColor.likeColor)
                .modifier(cornerRadiusVersion(cornerRadius: 2))
                .lineLimit(1)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .minimumScaleFactor(0.1)
                .frame(maxWidth: max)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}


#Preview {
    RankingCellView(
        ranking: 1,
        model: .init(
        productId: "1213123",
        title: "테스트 맥북 새거얌",
        link: "",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRB2IXX0Vhro4usLILe_kaeAc2rWcOfrLKiQg&s",
        lprice: "",
        hprice: "",
        mallName: "판매자"
    )
    )
}
