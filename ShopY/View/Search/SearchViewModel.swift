//
//  SearchViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine // 명시 사유: @Published는 콤바인 기반

// SearchViewModel
final class SearchViewModel: MVIPatternType {
    
    enum Intent {
        case viewOnAppear
        case deleteButtonTap(Int)
        case allDeleteButtonTap
        case searchButtonTap
        case currnetText(String)
    }
    
    struct StateModel {
        var searchList: [String] = []
        var searchText: String = ""
        var navTitle: String = "안녕하세요!"
    }
    
    @Published
    var stateModel = StateModel()

    private
    let realmRepository = RealmRepository()
    
}

// User Action Send
extension SearchViewModel {
    
    func send(action: Intent) {
        switch action{
        case .viewOnAppear:
            stateModel.searchList = UserDefaultManager.searchHistory
            findUserInfo()
            
        case .deleteButtonTap(let indexAt):
            stateModel.searchList.remove(at: indexAt)
            UserDefaultManager.searchHistory.remove(at: indexAt)
            
        case .allDeleteButtonTap:
            stateModel.searchList.removeAll()
            UserDefaultManager.searchHistory.removeAll()
            
        case .searchButtonTap:
            let searchText = stateModel.searchText
            UserDefaultManager.searchHistory.insert(searchText, at: 0)
            
        case .currnetText(let searchText):
            stateModel.searchText = searchText
        }
    }
}

// realm For User Profile
extension SearchViewModel {
    
    func findUserInfo() {
        
        let result = realmRepository.fetchAll(type: ProfileRealmModel.self)
    
        switch result {
        case .success(let success):
            
            if let userName = success.first?.name {
                stateModel.navTitle = userName + "님의 ShopY~!"
            } else {
                stateModel.navTitle = "검색해 보아요!"
            }
            
        case .failure:
            stateModel.navTitle = "검색해 보아요!"
        }
    }
}
