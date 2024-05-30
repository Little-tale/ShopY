//
//  InfiniteCarouselView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/30/24.
//

import SwiftUI
/*
 Timer 회고
 
 .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
 */

struct CarouselView: View {
    
    let headerTitle: String
    let imageName: String?
    let items: [ShopEntityModel]
    
    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(
        every: 3,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                if let imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                }
                Text(headerTitle)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.vertical, 4)
            }
            GeometryReader { geo in
                TabView(selection: $currentIndex) {
                    ForEach(0..<items.count, id: \.self) { index in
                        NavigationLink {
                            ShopResultView(model: items[index])
                        } label: {
                            CaraouselItemView(item: items[index])
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height
                                )
                                .tag(index)
                        }
                        .foregroundStyle(.primary)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(
                    width: geo.size.width,
                    height: geo.size.height
                )
                .onReceive(timer) { _ in
                    withAnimation {
                        if !items.isEmpty {
                            currentIndex = (currentIndex + 1) % items.count
                        }
                    }
                }
            }
           
        }
        .padding(.bottom, 6)
    }
    
}

