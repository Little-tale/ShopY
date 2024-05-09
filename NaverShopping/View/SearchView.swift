//
//  SearchView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import SwiftUI

struct SearchView: View {
    
    @State
    var searchText = ""
    
    @State
    var searchList:[String] = ["asda"]

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 10, content: {
                    Text("최근검색")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Text("모두 지우기").asButton {
                        searchList.removeAll()
                    }
                    .bold()
                    .foregroundStyle(.green)
                })
                .padding(.horizontal, 20)
            }
            .navigationTitle("떠나고 싶은 재형이의 쇼핑~")
            .navigationBarTitleDisplayMode(.inline)
            
            List(searchList.indices, id: \.self) { index in
                SearchListHView(text: searchList[index], xButtonTap: {
                    searchList.remove(at: index)
                }, tag: index)
            }
            .listStyle(.plain)
            Spacer()
        }
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            searchList.insert(searchText, at: 0)
        }
        
        
    }
}


#Preview {
    SearchView()
}
