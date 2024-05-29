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
            RootView()
        }
    }
    init(){
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(JHColor.white)
        UINavigationBar.appearance().standardAppearance = appearence
    }
}
