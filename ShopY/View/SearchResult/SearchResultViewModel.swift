//
//  SearchResultViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation
import Combine

final class SearchResultViewModel: MVIPatternType {
    
    var cancellabel: Set<AnyCancellable> = []
    
    @Published
    var stateModel = StateModel()
    
    private
    let repository = ShopItemsRepository()
    
    enum Intent {
        case searchText(String)
        case inputSort(SortCase)
        case inputCurrentIndex(Int)
        case likeStateChange((ShopEntityModel, Int))
        case onTapModel(ShopEntityModel, Int)
        case likeOnlyChanged(ShopEntityModel, Int)
    }
    
    struct StateModel {
        var ifNetworkError: NetworkError? = nil
        var drawRowViewModel: [ShopEntityModel] = []
        var goWebViewModel: (ShopEntityModel, Int)? = nil
        var total = 0
       
        var isError = false
        
        var realmError: RealmError? = nil
        
        var currentIndexAt = 0
        var currentAt = 1
        var currentSort: SortCase = .sim
        var currentTotal = 0
        var searchText = ""
        var isLoading: Bool = false
        var gotoTop: Bool = false
        var gotoWebView: Bool = false
    
        var totalConfig: String {
            return String(total) + "개의 검색 결과"
        }
    }
    
}

extension SearchResultViewModel {
    func send(_ action: Intent) {
        switch action {
        case .searchText(let searchText):
            stateModel.searchText = searchText
            requestModel()
            
        case .inputSort(let sort):
            if stateModel.currentSort != sort {
                stateModel.currentSort = sort
                stateModel.currentAt = 1
                stateModel.drawRowViewModel = []
                requestModel()
            } else {
                stateModel.gotoTop = true
                print(stateModel.gotoTop)
            }
        case .inputCurrentIndex(let index):
            stateModel.currentIndexAt = index
            testIfNextCursur()
            
        case .likeStateChange((let model, let indexAt)):
            likeState(model: model, indexAt: indexAt)
            
        case .onTapModel(let model, let number):
            moveToWebView(model, number: number)
            
        case .likeOnlyChanged(let model, let index):
            
            var models = stateModel.drawRowViewModel
            models[index] = model
            stateModel.drawRowViewModel = models
        }
    }
}

extension SearchResultViewModel {
    
    private func requestModel() {
        if stateModel.searchText == "" { return }
        repository.requestPost(
            search: stateModel.searchText,
            next: stateModel.currentAt,
            sort: stateModel.currentSort
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] result in
            if case .failure(let failure) = result {
                self?.stateModel.ifNetworkError = failure
                self?.stateModel.isError = true
            }
        }, receiveValue: {[weak self] result in
            guard let self else { return }
            
            var value = stateModel.drawRowViewModel
            
            value.append(contentsOf: result.models)
            
            stateModel.drawRowViewModel = value
            
            stateModel.currentTotal = value.count
    
            stateModel.total = result.total
            
            stateModel.isLoading = false
        })
        .store(in: &cancellabel)
    }
    
    private func testIfNextCursur(){
        
        if stateModel.currentTotal == 0 { return }
        
        if stateModel.currentTotal - 5 < stateModel.currentIndexAt && !stateModel.isLoading {
            stateModel.isLoading = true
            updateRequest()
        }
    }
    
    private
    func updateRequest() {
        let value = stateModel.currentAt + 1
        stateModel.currentAt = value
        requestModel()
    }
    
    private 
    func likeState(model: ShopEntityModel, indexAt: Int){
        let result = repository.likeRegOrDel(model)
        if case .failure(let failure) = result {
            stateModel.realmError = failure
            stateModel.isError = true
        }
        stateModel.drawRowViewModel[indexAt].likeState.toggle()
    }
    
    
    private
    func moveToWebView(_ model: ShopEntityModel, number: Int) {
        stateModel.goWebViewModel = (model, number)
        stateModel.gotoWebView = true
    }
}
