//
//  RootView .swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/21/24.
//

import SwiftUI

struct RootView: View {
    
    @StateObject
    private var viewModel = RootViewModel()
    
    var body: some View {
        Group {
            switch viewModel.stateModel.currentRoot {
            case .splash:
                InterAppView
            case .startView:
                splashView()
            case .tabbarView:
                TabbarView()
            }
        }
        .alert("Error",
               isPresented: $viewModel.stateModel.alertTrigger)
        {
            Text(viewModel.stateModel.error.message)
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
        .onAppear {
            viewModel.send(action: .viewOnAppear)
        }
    }
}

#Preview {
    RootView()
}

