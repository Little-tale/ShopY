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
    
    var body: some View {
        VStack {
            WKWebRepresentView(url: model.link)
        }
        .navigationTitle(model.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeartButton(
                    isSelected: $viewModel.stateModel.likeState, tag: nil) {
                        viewModel.send(.changedState)
                    }
            }
        }
        .onAppear{
            viewModel.send(.startModel(model))
        }
        .navigationTitle(viewModel.stateModel.navTititle)
        .onDisappear {
            if let model = viewModel.stateModel.currentModel {
                changeedModel?(model)
            }
        }
    }
}
