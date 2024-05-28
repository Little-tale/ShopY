//
//  TabbarView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//
/*
 회고
 EnvironmentObject
 
 */
import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject var navigationManager: RootViewModel
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            SettingView()
                .environmentObject(navigationManager)
                .tabItem {
                    Image(systemName: "person")
                    Text("MY")
                }
                
        }
    }
    
    init(){
        navigationStyle()
        navigationButtonStyle()
    }
}
