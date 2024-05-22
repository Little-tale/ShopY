//
//  TabbarView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import SwiftUI

struct TabbarView: View {
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
        }
    }
}
