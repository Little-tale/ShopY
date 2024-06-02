//
//  ShopResultView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import SwiftUI

struct ShopResultView: View {
    
    let model: ShopEntityModel
    
    @StateObject
    var viewModel = ShopResultViewModel()
    
    var changeedModel: ((ShopEntityModel) -> Void)?
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        
        WKWebRepresentView(url: model.link)
            .ignoresSafeArea()
            .navigationTitle(model.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HeartButton(
                        isSelected: $viewModel.stateModel.likeState, tag: nil, clear: true) {
                            viewModel.send(.changedState)
                        }
                }
            }
            .onAppear{
                viewModel.send(.startModel(model))
            }
            .navigationTitle(viewModel.stateModel.navTititle)
            .onDisappear {
                print("@@ 왜죠...")
                if let model = viewModel.stateModel.currentModel {
                    changeedModel?(model)
                }
                navigationManager.send(.showTabbar)
            }
    }
}
