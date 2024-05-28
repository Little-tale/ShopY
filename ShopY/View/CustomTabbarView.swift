//
//  CustomTabbarVIew.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/28/24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
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
    
    @State var selectedTab = 0
    
    @EnvironmentObject var navigationManager: RootViewModel
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                SearchView()
                    .tag(0)
                
                SettingView()
                    .environmentObject(navigationManager)
                    .tag(1)
            }
        }
        ZStack{
            HStack{
                ForEach((TabbedItems.allCases), id: \.self){ item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(
                            imageName: item.iconName,
                            title: item.title,
                            isActive: (selectedTab == item.rawValue)
                        )
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 60)
        .background(JHColor.likeColor.opacity(0.2))
        .modifier(cornerRadiusVersion(cornerRadius: 24))
        .padding(.horizontal, 26)
    }
}

extension CustomTabbarView {
    
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(isActive ? JHColor.likeColor.opacity(0.4) : .clear)
        .modifier(cornerRadiusVersion(cornerRadius: 24))
    }
}

struct cornerRadiusVersion: ViewModifier {
    
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            return content
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius)
                )
        } else {
            return content
                .cornerRadius(cornerRadius)
        }
    }
}

