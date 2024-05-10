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
    
    
    var searchText: String
    
    @State
    var likeState = true
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle(searchText)
    }
    
}


//#Preview {
//    SearchResultView()
//}
