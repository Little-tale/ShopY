//
//  ShopYCustomTabBarView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/31/24.
//

import SwiftUI

struct ShopYCustomTabbarView: View {
    
    @Binding
    var selectedTab: Int
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 70)
                .foregroundStyle(JHColor.likeColor.opacity(0.6))
                .shadow(radius: 2)
            
            HStack {
                ForEach(TabbedItems.allCases, id: \.self) { item in
                    CustomTabItem(
                        imageName: item.iconName,
                        title: item.title,
                        isActive: (selectedTab == item.rawValue)
                    )
                    .asButton {
                        selectedTab = item.rawValue
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        
        
        .padding(.horizontal)
    }
}

extension ShopYCustomTabbarView {
    
    func CustomTabItem(
        imageName: String,
        title: String,
        isActive: Bool
    ) -> some View {
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
        .frame(height: 46)
        .background(isActive ? JHColor.likeColor.opacity(0.8) : .clear)
        .modifier(cornerRadiusVersion(cornerRadius: 24))
    }
}
