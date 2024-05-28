//
//  NavigationManager.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/28/24.
//

import Foundation

final class NavigationManager: ObservableObject {
    
    @Published var rootScreen: Screen
    
    enum Screen: Hashable {
        case main
        case start
    }
    
    init(rootScreen: Screen) {
        self.rootScreen = rootScreen
    }
    
}
