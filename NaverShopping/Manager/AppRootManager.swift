//
//  AppRootManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation


final class AppRootManager: ObservableObject {
    
    @Published
    var currentRoot: Roots = .splash
    
    enum Roots {
        case splash
        case startView
        case tabbarView
    }
}
