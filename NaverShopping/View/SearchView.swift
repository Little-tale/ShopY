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

    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 10, content: {
                    Text("최근검색")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Text("모두 지우기").asButton {
                        viewModel.input.allDeleteButtonTap.send(())
                    }
                    .bold()
                    .foregroundStyle(.green)
                })
                .padding(.horizontal, 20)
            }
            .navigationTitle("떠나고 싶은 재형이의 쇼핑~")
            .navigationBarTitleDisplayMode(.inline)
            
            List(viewModel.output.searchList
                .indices, id: \.self) { index in
                SearchListHView(text: viewModel.output.searchList[index], xButtonTap: {
                    viewModel.input.deleteButtonTap.send(index)
                }, tag: index)
            }
            .listStyle(.plain)
            Spacer()
        }
        .searchable(
            text: $viewModel.input.currentText,
            placement: .navigationBarDrawer(
                displayMode: .always
            )
        )
        .onSubmit(of: .search) {
            viewModel.input.searchButtonTap.send(())
        }
        .task {
            viewModel.input.viewOnAppear.send(())
        }
    }
}


#Preview {
    SearchView()
}
