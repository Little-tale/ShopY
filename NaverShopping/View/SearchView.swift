//
//  SearchView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private
    var viewModel = SearchViewModel()
    
    @State
    var navigationIsPresented = false
    
    @State
    var selectionIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 10) {
                    Text("최근검색")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Button("모두 지우기") {
                        viewModel.input.allDeleteButtonTap.send(())
                    }
                    .bold()
                    .foregroundColor(.green)
                }
                .padding(.horizontal, 20)
       
                    
                List(viewModel.output.searchList.indices, id: \.self) { index in
                    NavigationLink {
                        SearchResultView(searchText: viewModel.output.searchList[index])
                    } label: {
                        SearchListHView(text: viewModel.output.searchList[index], xButtonTap: {
                            viewModel.input.deleteButtonTap.send(index)
                        }, tag: index)
                    }
                }
                .listStyle(.plain)
                
                .navigationDestination(isPresented: $navigationIsPresented) {
                    SearchResultView(searchText: viewModel.output.searchText)
                }
                Spacer()
            }
            .navigationTitle("떠나고 싶은 재형이의 쇼핑~")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.input.currentText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                viewModel.input.searchButtonTap.send(())
                navigationIsPresented = true
            }
        }
        .task {
            viewModel.input.viewOnAppear.send(())
        }
        
    }
}


#Preview {
    SearchView()
}
