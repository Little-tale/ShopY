//
//  NaverShoppingApp.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

@main
struct NaverShoppingApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("검색")
                    }
                SplashView()
                    .tabItem {
                        Text("시작")
                    }
            }
            
        }
    }
    init(){
        UINavigationBar.appearance().isTranslucent = false
    }
}
