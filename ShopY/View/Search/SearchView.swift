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
    
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                iOS16OverView
            } else {
                iOS15View
            }
        }
        .tint(.black)
         
    }
    
    
    @available(iOS 16, *)
    private var iOS16OverView: some View {
        NavigationStack {
            mainContent
                .navigationDestination(isPresented: $navigationIsPresented) {
                    SearchResultView(searchText: viewModel.stateModel.searchText)
                }
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
            viewModel.send(action: .viewOnAppear)
        }
        .onChange(of: navigationIsPresented) { newValue in
            if !newValue {
                viewModel.send(action: .viewOnAppear)
            }
        }
    }
    
    
    private var iOS15View: some View {
        NavigationView {
            mainContent
                .background(
                    NavigationLink(
                        destination: SearchResultView(searchText: viewModel.stateModel.searchText),
                        isActive: $navigationIsPresented,
                        label: { EmptyView() }
                    )
                )
        }
        .onAppear {
            viewModel.send(action: .viewOnAppear)
        }
        .onChange(of: navigationIsPresented) { newValue in
            if !newValue {
                viewModel.send(action: .viewOnAppear)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private 
    var mainContent: some View {
        VStack {
            searchHeader
            searchList
            Spacer()
        }
        .navigationTitle(viewModel.stateModel.navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: Binding(get: {
                viewModel.stateModel.searchText
            }, set: { text in
                viewModel.send(action: .currnetText(text))
            }),
            placement: .automatic
        )
        .onSubmit(of: .search) {
            viewModel.send(action: .searchButtonTap)
            navigationIsPresented = true
        }
        .onAppear {
            viewModel.stateModel.searchText = ""
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
                viewModel.send(action: .allDeleteButtonTap)
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.green)
        }
        .padding(.horizontal, 20)
    }
    
    private var searchList: some View {
        List(viewModel.stateModel.searchList.indices, id: \.self) { index in
            Button(action: {
                viewModel.stateModel.searchText = viewModel.stateModel.searchList[index]
                navigationIsPresented = true
            }) {
                SearchListHView(text: viewModel.stateModel.searchList[index], xButtonTap: {
                    viewModel.send(action: .deleteButtonTap(index))
                }, tag: index)
            }
            .tint(JHColor.black)
        }
        .listStyle(.plain)
    }
}

