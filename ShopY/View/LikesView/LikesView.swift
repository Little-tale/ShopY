//
//  LikesView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import SwiftUI

struct LikesView: View {
    
    private
    var rows: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject
    private var viewModel = LikeViewModel()
    
    var body: some View {
        
        Group {
            if #available(iOS 16, *) {
                contentView
                    .navigationDestination(
                        isPresented: $viewModel.stateModel.moveToWebView
                    ) {
                        if let model = viewModel.stateModel.moveModel {
                            ShopResultView(
                                model: model.0
                            ) { changed in
                                viewModel.send(.onAppear)
                            }
                        }
                    }
            } else {
                contentView
                NavigationLink(isActive: $viewModel.stateModel.moveToWebView) {
                    if let model = viewModel.stateModel.moveModel {
                        ShopResultView(
                            model: model.0
                        ) { changed in
                            viewModel.send(.onAppear)
                        }
                    }
                } label: {
                    EmptyView()
                }
            }
        }
        .alert(isPresented: $viewModel.stateModel.ifError) {
            Alert(
                title: Text("에러"),
                message: Text(viewModel.stateModel.error.message),
                primaryButton: .destructive(Text("확인")),
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
        .navigationTitle("좋아요")
    }
}
// ContentView
extension LikesView {
    var contentView: some View {
        ScrollView {
            LazyVGrid(columns: rows) {
                ForEach(Array(viewModel.stateModel.currentLikes.enumerated()), id: \.element.self) {
                    index, model in
                    VirticalResultRowView(
                        model: .constant(model)
                    ) { item in // heartButtonTapped
                        
                        viewModel.send(.likeStateChange(item, index))
                    }
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        
                        viewModel.send(.onTapModel(model, index))
                    }
                }
            }
        }
    }
}

#Preview {
    LikesView()
}
