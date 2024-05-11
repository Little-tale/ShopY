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
                        Image("exclamationmark.magnifyingglass")
                    }
            }
            
        }
    }
    init(){
        UINavigationBar.appearance().isTranslucent = false
    }
}
