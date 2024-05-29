//
//  HomeView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import SwiftUI

struct RankingHomeView: View {
    
    @State private var currentPage: String = ""
    
    
    @StateObject
    private var viewModel = RankingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if #available(iOS 16, *) {
                ios16
            } else {
                ios15
            }
        }
        .onAppear {
            viewModel.send(action: .onAppear)
        }
    }
}

@available(iOS 16.0, *)
extension RankingHomeView {
    
    var ios16: some View {
        return NavigationStack {
            contentView
        }
        
    }
}
extension RankingHomeView {
    
    var ios15: some View {
        NavigationView {
            contentView
        }
        .navigationViewStyle(.stack)
    }
}

// Main
extension RankingHomeView {
    
    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                ForEach(RankingViewModel.HomeCategorySection.allCases, id: \.self) { section in
                    RankingSectionView(
                        image: section.imageName,
                        title: section.headerTitle,
                        items: viewModel.stateModel.items[section] ?? []
                    )
                }
            }
            .navigationTitle("실시간 랭킹")
            .navigationBarItems(
                leading: Text("ShopY")
                    .font(.system(size: 25, weight: .black, design: .monospaced))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [JHColor.warningColor, JHColor.onlyDarkGray],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            UITabBar.appearance().isHidden = false
        }
    }
}

struct RankingSectionView: View {
    let image: String
    let title: String
    let items: [ShopEntityModel]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0){
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 50)
                    .padding(.leading, 8)
                
                Text(title)
                    .font(.system(size: 30,weight: .bold, design: .default))
                    .padding(.leading, 10)
            }
            .padding(.vertical, 3)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(zip(items.indices, items)), id:\.1.productId) {
                        index, item in
                        RankingCellView(
                            ranking: (
                                index + 1
                            ),
                            model: item
                        )
                    }
                }
                
            }
        }
    }
}
