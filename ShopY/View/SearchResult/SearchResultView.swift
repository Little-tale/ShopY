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
            ScrollView(.vertical) {
                HStack {
                    Spacer()
                    Text(viewModel.stateModel.totalConfig)
                    .padding(.trailing, 10)
                }
                LazyVGrid(columns: gridItem, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        ForEach(Array(
                            viewModel.stateModel.drawRowViewModel.enumerated()),
                                 id: \.element.id) {index, model in
                            VirticalResultRowView(
                                model: .constant(model)
                            ) { item in // heartButtonTapped
                                viewModel.send(.likeStateChange((item, index)))
                            }
                            .padding(.horizontal, 10)
                            .onAppear {
                                viewModel.send(.inputCurrentIndex(index))
                            }
                        }
                    } header: {
                        HeaderView(
                            inputSort: Binding(get: {
                                viewModel.stateModel.currentSort
                            }, set: { value in
                                viewModel.send(.inputSort(value))
                            })
                        )
                        .padding(.all, 6)
                        .background(JHColor.white)
                    } // header
                } // content
                ) // LazyVGrid
            } // ScrollView
            
        } // VStack
        .task {
            viewModel.send(.searchText(searchText))
        }
        .alert(isPresented: $viewModel.stateModel.isError) {
            Alert(
                title: Text("에러"),
                message: Text(alertMessage),
                primaryButton: .destructive(Text("확인")),
                secondaryButton: .cancel()
            )
        }
        .navigationTitle(searchText)
    }
    
    private var alertMessage: String {
        if let network = viewModel.stateModel.ifNetworkError {
            return network.errorMessgae
        } else if let realm = viewModel.stateModel.realmError {
            return realm.message
        } else {
            return "알 수 없는 에러"
        }
    }
}

struct SearchSortButtonStyle: ButtonStyle {
    
    var state: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(JHColor.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 7)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(state ? JHColor.likeColor : JHColor.black)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
    
}

struct HeaderView: View{
    
    @Binding
    var inputSort: SortCase
    
    //var sortClosure: (SortCase) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(SortCase.allCases, id: \.name) { sort in
                Text(sort.name)
                    .asButton {
                        //sortClosure(sort)
                        print("이게눌림",sort.name)
                        inputSort = sort
                    }
                    .buttonStyle(
                        SearchSortButtonStyle(state: inputSort == sort )
                    )
            }
            Spacer()
        } // HStack
    }
}
