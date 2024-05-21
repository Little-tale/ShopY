//
//  RootView .swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/21/24.
//

import SwiftUI

struct RootView: View {
    
    @StateObject
    private 
    var appRootManager = AppRootManager()
    
    var body: some View {
        Group {
            switch appRootManager.currentRoot {
            case .splash:
                InterAppView
            case .startView:
                splashView()
            case .tabbarView:
                TabbarView()
            }
        }
    }
}

extension RootView {
    
    var InterAppView: some View {
        VStack{
            Spacer()
            Text("로딩창")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Spacer()
        }
        .onAppear(
            
        )
    }
}

#Preview {
    RootView()
}

