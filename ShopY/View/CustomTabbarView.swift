//
//  CustomTabbarVIew.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/28/24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "검색"
        case .profile:
            return "프로필"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "magnifyingglass"
        case .profile:
            return "person"
        }
    }
}

struct CustomTabbarView: View {
    
    @State private var selectedTab = 0
    @EnvironmentObject var navigationManager: RootViewModel
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                SearchView()
                    .tag(TabbedItems.home.rawValue)
                
                SettingView()
                    .environmentObject(navigationManager)
                    .tag(TabbedItems.profile.rawValue)
            }
            .ignoresSafeArea(edges: .bottom)
            if !navigationManager.stateModel.tabbarisHidden {
                customTabBar
            }
        }
    }
    
    private var customTabBar: some View {
        HStack {
            ForEach(TabbedItems.allCases, id: \.self) { item in
                Button(action: {
                    selectedTab = item.rawValue
                }) {
                    CustomTabItem(
                        imageName: item.iconName,
                        title: item.title,
                        isActive: (selectedTab == item.rawValue)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(6)
        .frame(height: 60)
        .background(JHColor.likeColor.opacity(0.7))
        .modifier(cornerRadiusVersion(cornerRadius: 24))
        .padding(.horizontal, 26)
    }
}

extension CustomTabbarView {
    
    func CustomTabItem(
        imageName: String,
        title: String,
        isActive: Bool
    ) -> some View {
        VStack {
            HStack(spacing: 10) {
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
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isActive ? JHColor.likeColor.opacity(0.8) : .clear)
            .modifier(cornerRadiusVersion(cornerRadius: 24))
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
