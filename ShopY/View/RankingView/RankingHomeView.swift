//
//  HomeView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import SwiftUI

struct RankingHomeView: View {
    
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
            VStack(alignment: .leading) {
                ForEach(RankingViewModel.HomeCategorySection.allCases, id: \.self) { section in
                    RankingSectionView(
                        image: section.imageName,
                        title: section.headerTitle,
                        items: viewModel.stateModel.items[section] ?? []
                    )
                }
            }
            .padding()
            .navigationTitle("실시간 랭킹")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RankingSectionView: View {
    let image: String
    let title: String
    let items: [ShopEntityModel]
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack(alignment: .center, content: {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 50)
                    
                Text(title)
                    .font(.system(size: 30,weight: .bold, design: .default))
                    .padding(.leading, 10)
            })
            
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



#Preview {
    RankingHomeView()
}
