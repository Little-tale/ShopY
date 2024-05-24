//
//  ExView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/25/24.
//

import SwiftUI

extension View {
    // 네비게이션
    func navigationStyle() {
        let appear = UINavigationBarAppearance()
    
        appear.configureWithOpaqueBackground()
        appear.backgroundColor = UIColor(JHColor.white)
        appear.titleTextAttributes = [.foregroundColor: UIColor(JHColor.black)]
        appear.largeTitleTextAttributes = [.foregroundColor: UIColor(JHColor.white)]
        
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    // 네비게이션 버튼
    func navigationButtonStyle(){
        let barButtonAppear = UIBarButtonItem.appearance()
        barButtonAppear.tintColor = UIColor(JHColor.black)
    }
}
