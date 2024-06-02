//
//  CustomTabbarVIew.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/28/24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case search
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .search:
            return "검색"
        case .profile:
            return "프로필"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .profile:
            return "person"
        }
    }
}

struct CustomTabbarView: View {
    
    @State private var selectedTab = 0
    @EnvironmentObject var navigationManager: NavigationManager
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack (spacing: 0) {
            TabView(selection: $selectedTab) {
                RankingView()
                    .environmentObject(navigationManager)
                    .tag(TabbedItems.home.rawValue)
                
                SearchView()
                    .environmentObject(navigationManager)
                    .tag(TabbedItems.search.rawValue)
        
                SettingView()
                    .environmentObject(navigationManager)
                    .tag(TabbedItems.profile.rawValue)
            }
            .onChange(of: navigationManager.stateModel.gosearchView) { value in
                selectedTab = 1
            }
            if !navigationManager.stateModel.tabbarisHidden {
                customTabBar
                    .environmentObject(navigationManager)
            }
        }
    }
    
    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(TabbedItems.allCases, id: \.self) { item in
                CustomTabItem(
                    imageName: item.iconName,
                    title: item.title,
                    isActive: (selectedTab == item.rawValue)
                )
                .frame(maxWidth: .infinity)
                .asButton {
                    selectedTab = item.rawValue
                }
            }
        }
        .padding(6)
        .frame(height: 70)
        .background(JHColor.likeColor.opacity(0.7))
        .modifier(cornerRadiusVersion(cornerRadius: 28))
        .padding(.horizontal, 14)
    }
    
    private func CustomTabItem(
        imageName: String,
        title: String,
        isActive: Bool
    ) -> some View {
        VStack {
            HStack (spacing: 0) {
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isActive ? JHColor.onlyWhite : JHColor.gray)
                    .frame(width: 20, height: 20)
                
                if isActive {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(isActive ? JHColor.onlyWhite : JHColor.gray)
                        .padding(.horizontal, 4)
                }
                Spacer()
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(isActive ? JHColor.likeColor.opacity(0.8) : .clear)
            .modifier(cornerRadiusVersion(cornerRadius: 16))
        }
    }
}

struct cornerRadiusVersion: ViewModifier {
    
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            content
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )
        } else {
            content
                .cornerRadius(cornerRadius)
        }
    }
}

struct ignoreViewModifier: ViewModifier {

    var ifIgnoreView: Bool
    
    func body(content: Content) -> some View {
        Group {
            if ifIgnoreView {
                content
                    .ignoresSafeArea(edges: .bottom)
            } else {
                content
            }
        }
    }
}
