//
//  SearchView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject 
    private var viewModel = SearchViewModel()
    
    @State 
    var navigationIsPresented = false
    
    @State
    var selectionIndex = 0
    
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                iOS16OverView
            } else {
                iOS15View
            }
        }
        .tint(.black)
        .onAppear {
            viewModel.input.viewOnAppear.send(())
        }
    }
    
    @ViewBuilder @available(iOS 16, *)
    private var iOS16OverView: some View {
        NavigationStack {
            mainContent
                .navigationDestination(isPresented: $navigationIsPresented) {
                    SearchResultView(searchText: viewModel.output.searchText)
                }
        }
    }
    
    @ViewBuilder
    private var iOS15View: some View {
        NavigationView {
            mainContent
                .background(
                    NavigationLink(
                        destination: SearchResultView(searchText: viewModel.output.searchText),
                        isActive: $navigationIsPresented,
                        label: { EmptyView() }
                    )
                )
        }
    }
    
    private 
    var mainContent: some View {
        VStack {
            searchHeader
            searchList
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
    
    private 
    var searchHeader: some View {
        HStack(spacing: 10) {
            Text("최근검색")
                .font(.callout)
                .bold()
            Spacer()
            Button("모두 지우기") {
                viewModel.input.allDeleteButtonTap.send(())
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.green)
        }
        .padding(.horizontal, 20)
    }
    
    private var searchList: some View {
        List(viewModel.output.searchList.indices, id: \.self) { index in
            Button(action: {
                viewModel.output.searchText = viewModel.output.searchList[index]
                navigationIsPresented = true
            }) {
                SearchListHView(text: viewModel.output.searchList[index], xButtonTap: {
                    viewModel.input.deleteButtonTap.send(index)
                }, tag: index)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchView()
}
