//
//  RootView .swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/21/24.
//

import SwiftUI

struct RootView: View {
    
    @StateObject // iOS 14
    private var viewModel = RootViewModel()
    
    
    var body: some View {
        Group { // iOS 12
            switch viewModel.stateModel.currentRoot {
            case .splash:
                InterAppView
            case .startView:
                splashView()
                    .environmentObject(viewModel)
            case .tabbarView:
                CustomTabbarView()
                    .environmentObject(viewModel)
            }
        }
        .alert("Error",  // iOS 15.0
               isPresented: $viewModel.stateModel.alertTrigger)
        {
            Text(viewModel.stateModel.error.message)
        }
    }
    
    init(){
        navigationStyle()
        navigationButtonStyle()
    }
}

extension RootView {
    
    var InterAppView: some View {
        VStack{
            Spacer()
            Text("로딩창") // iOS 13
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Spacer()
        }
        .onAppear { // iOS 13
            viewModel.send(action: .viewOnAppear)
        }
    }
}

#Preview {
    RootView()
}

