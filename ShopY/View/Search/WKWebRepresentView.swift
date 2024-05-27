//
//  WKWebViewRepresent.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import SwiftUI
import WebKit

struct WKWebRepresentView: UIViewRepresentable {
    
    var url: String
   
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            print("init URL ISSUE: FOR MAKE UIView")
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ wkView: WKWebView, context: UIViewRepresentableContext<WKWebRepresentView>) {
        guard let url = URL(string: url) else {
            print("init URL ISSUE: FOR MAKE updateUIView")
            return
        }
        
        wkView.load(URLRequest(url: url))
    }
    
}


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
                        let bool = viewModel.stateModel.likeState
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
                print("바껴야만 했다니까 ",model.likeState)
                changeedModel?(model)
            }
        }
    }
}
