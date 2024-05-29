//
//  HomeView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import SwiftUI

struct RankingHomeView: View {
    
    @StateObject
    private var viewModel = RankingViewModel()
    
    var body: some View {
        
        VStack {
         
        }
        
        .onAppear {
            // viewModel.send(action: .onAppear)
        }
    }
    
}
// Main
extension RankingHomeView {
    
    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(RankingViewModel.HomeCategorySection.allCases, id: \.self) { section in
                    
                }
            }
        }
    }
}

extension RankingHomeView {
    
    func SectionInRankingView(section: RankingViewModel.HomeCategorySection) {
        
    }
    
}



#Preview {
    RankingHomeView()
}
