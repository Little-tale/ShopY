//
//  HomeView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import SwiftUI

struct RankingView: View {
    
    @State private var currentPage: String = ""
    
    @State private var tabbarHiddenTrigger = false
    
    @StateObject
    private var viewModel = RankingViewModel()
    
    @EnvironmentObject
    private var navigationManager: NavigationManager
    
    @State private var selectedModel: ShopEntityModel?
    @State private var isLinkActive = false
    
    var body: some View {
        VStack(spacing: 0) {
            if #available(iOS 16, *) {
                ios16
            } else {
                ios15
            }
        }
        
    }
}

@available(iOS 16.0, *)
extension RankingView {
    
    var ios16: some View {
        return NavigationStack {
            contentView
        }
    }
}
extension RankingView {
    
    var ios15: some View {
        NavigationView {
            contentView
        }
        .navigationViewStyle(.stack)
    }
}

// Main
extension RankingView {
    
    var contentView: some View {
        ScrollView {
            fakeSearchView
            
            VStack(alignment: .leading, spacing: 0) {
                CarouselView(
                    headerTitle: Const.RankingToBanner.headerText,
                    imageName: Const.RankingToBanner.appleImageName,
                    items: viewModel.stateModel.bannerItems
                )
                .frame(height: 300)
                ForEach(Const.RankingSection.allCases, id: \.self) { section in
                    RankingSectionView(
                        image: section.imageName,
                        title: section.headerTitle,
                        items: viewModel.stateModel.items[section] ?? [],
                        selectedModel: $selectedModel,
                        isLinkActive: $isLinkActive
                    )
                    .environmentObject(navigationManager)
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
            viewModel.send(.onAppear)
        }
        .background(
            NavigationLink(
                destination: selectedModel.map { ShopResultView(model: $0)
                        .environmentObject(navigationManager)
                },
                isActive: $isLinkActive,
                label: { EmptyView() }
            )
        )
    }
}

extension RankingView {
    var fakeSearchView: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: Const.searchImage)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                Text(Const.searchMent)
                    .padding(.trailing,8)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .stroke(Color.black, lineWidth: 2)
            )
            .asButton {
                print("선택됨")
                navigationManager.send(.showSearchView)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.all)
        }
    }
}

struct RankingSectionView: View {
    let image: String
    let title: String
    let items: [ShopEntityModel]
    
    @Binding
    var selectedModel: ShopEntityModel?
    @Binding
    var isLinkActive: Bool
    
    @EnvironmentObject
    private var navigationManager: NavigationManager
    
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
                    ForEach(Array(zip(items.indices, items)), id: \.1.productId) { index, item in
                        RankingCellView(
                            ranking: index + 1,
                            model: item
                        )
                        .asButton {
                            print("@@@ 작동.!")
                            navigationManager.send( .hideTabbar)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                selectedModel = item
                                isLinkActive = true
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}
