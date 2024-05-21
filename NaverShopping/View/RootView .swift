//
//  RootView .swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/21/24.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
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
