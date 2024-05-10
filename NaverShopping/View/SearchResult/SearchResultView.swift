//
//  SearchResultView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import SwiftUI



struct SearchResultView: View {
    
    private
    let gridItem: [GridItem] = Array(
        repeating: GridItem(.flexible(), alignment: .center),
        count: 2
    )
    
    @StateObject private
    var viewModel = SearchResultViewModel()
    
    var searchText: String
    
    @State
    var likeState = true
    
   
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItem, content: {
                    ForEach($viewModel.output.drawRowViewModel, id: \.productId) { model in
    
                        VirticalResultRowView(model: model) { num in
                            print(num)
                        }
                        .padding(.horizontal, 10)
                    }
                })
            }
        }
        .task {
            viewModel.input.searchText.send(searchText)
        }
        .alert(isPresented: $viewModel.output.isError) {
            Alert(
                title: Text("에러"),
                message: Text(viewModel.output.ifNetworkError.value?.errorMessgae ?? "none"),
                primaryButton: .destructive(Text("확인")),
                secondaryButton: .cancel()
            )
        }
        .navigationTitle(searchText)
    }
    
}

#Preview {
    SearchView()
}
