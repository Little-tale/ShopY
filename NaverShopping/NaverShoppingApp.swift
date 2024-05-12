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
                Step2View()
                    .tabItem {
                        Image("person")
                        Text("테스트...")
                    }
            }
            
        }
    }
    init(){
        UINavigationBar.appearance().isTranslucent = false
    }
}
