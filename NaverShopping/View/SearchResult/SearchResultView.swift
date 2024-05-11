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
                        HeaderView(
                            inputSort: $viewModel.input.inputSort.value,
                            sortClosure: { sort in
                                viewModel.input.inputSort.send(sort)
                            }
                        )
                        .padding(.all, 6)
                        .background(JHColor.white)
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
    
    var sortClosure: (SortCase) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(SortCase.allCases, id: \.name) { sort in
                Text(sort.name)
                    .asButton {
                        sortClosure(sort)
                        print("이게눌림",sort.name)
                    }
                    .buttonStyle(
                        SearchSortButtonStyle(state: inputSort == sort )
                    )
            }
            Spacer()
        } // HStack
    }
}


#Preview {
    SearchView()
}
