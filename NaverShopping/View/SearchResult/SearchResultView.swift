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
                    Text(String(viewModel.output.total.value) +
                         "개의 검색 결과")
                    .padding(.trailing, 10)
                }
                LazyVGrid(columns: gridItem, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        ForEach( Array(
                            viewModel.output.drawRowViewModel.enumerated()),
                                 id: \.element.id) {index, model in
                            VirticalResultRowView(
                                model: .constant(model)
                            ) { item in // heartButtonTapped
                                print(item, index)
                                viewModel.input.likeStateChange.send((item,index))
                            }
                            .padding(.horizontal, 10)
                            .onAppear {
                                // print(model)
                                viewModel.input.inputCurrentIndex.send(index)
                            }
                        }
                    } header: {
                        HStack(spacing: 12) {
                            ForEach(SortCase.allCases, id: \.name) { sort in
                                Text( sort.name)
                                    .asButton {
                                        viewModel.input.inputSort.send(sort)
                                        print("이게눌림",sort.name)
                                    }
                                    .padding(4)
                                    .background(Color.purple)
                            }
                            .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.all, 6)
                        .background(Color.teal)
                    } // header
                } // content
                ) // LazyVGrid
            } // ScrollView
            
        } // VStack
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
