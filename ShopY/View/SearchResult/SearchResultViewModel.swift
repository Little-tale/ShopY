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
    
    var int = 0
    
    @Published
    var stateModel = StateModel()
    
    private
    let repository = ShopItemsRepository()
    
    enum Intent {
        case searchText(String)
        case inputSort(SortCase)
        case inputCurrentIndex(Int)
        case likeStateChange((ShopEntityModel, Int))
    }
    
    struct StateModel {
        var ifNetworkError: NetworkError? = nil
        var drawRowViewModel: [ShopEntityModel] = []
        var total = 0
       
        var isError = false
        
        var realmError: RealmError? = nil
        
        var currentIndexAt = 0
        var currentAt = 1
        var currentSort: SortCase = .sim
        var currentTotal = 0
        var searchText = ""
        var isLoading: Bool = false
    
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
            stateModel.currentSort = sort
            stateModel.currentAt = 1
            stateModel.drawRowViewModel = []
            requestModel()
            
        case .inputCurrentIndex(let index):
            stateModel.currentIndexAt = index
            testIfNextCursur()
            
        case .likeStateChange((let model, let indexAt)):
            likeState(model: model, indexAt: indexAt)
        }
    }
}

extension SearchResultViewModel {
    
    private func requestModel() {
        if stateModel.searchText == "" { return }
//        dump(stateModel)
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
        int += 1
        print("재요청 횟수 :", int)
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
    
}

//    func transform() {
//
////        var currentTotal = 0
////
////        let searchQueryItems = PassthroughSubject<SearchQueryItems, Never> ()
////
////        let display = CurrentValueSubject<Int, Never>(30)
////
////        let start = CurrentValueSubject<Int, Never> (1)
////
////        let realmErrorTrigger = PassthroughSubject<RealmError, Never> ()
//
////        output.realmError = realmErrorTrigger
//
//        // distinctUntilChanged
////        let sort = input.inputSort
////            .removeDuplicates(by: { lcase, rcase in
////                lcase.name == rcase.name
////            })
////            .map {[weak self] sort in
////                self?.output.drawRowViewModel.removeAll()
////                start.send(1)
////                return sort
////            }
//
////        input.searchText
////            .combineLatest(sort, start, display)
////            .map({ (text, sort, start, display) in
////                return (text: text, sort: sort, start: start, display: display)
////            })
////            .debounce(for: 0.1, scheduler: RunLoop.main)
////            .sink { combined in
////                let query = SearchQueryItems(
////                    searchText: combined.text,
////                    display: combined.display,
////                    start: combined.start,
////                    sort: combined.sort.rawValue
////                )
////                searchQueryItems.send(query)
////            }
////            .store(in: &cancellabel)
////
////        searchQueryItems
////            .flatMap({ queryItems in
////                print("쿼리 아이템 \(queryItems)")
////                let result = NetworkManager.fetchNetwork(
////                    model: Shop.self,
////                    router: .search(
////                        query: queryItems
////                    )
////                )
////                dump(queryItems)
////                return result
////            })
////            .receive(on: DispatchQueue.main)
////            .sink(receiveCompletion: {[weak self] result in
////                switch result {
////                case .finished:
////                    print("성공은 했어요!")
////                    break
////                case .failure(let error):
////                    print("에러가 나요",error)
////                    self?.output.isError = true
////                    self?.output.ifNetworkError.send(error)
////                }
////            }, receiveValue: { [weak self] shop in
////                print("성공한 모델이에여")
////                guard let strongSelf = self else { return }
////
////                var datas = strongSelf.output.drawRowViewModel
////
////                datas.append(contentsOf: shop.items.map({ item in
////                    var new = item
////                    let model = strongSelf.repository.fetchAll(type: LikePostModel.self)
////                    if case .success(let success) = model {
////                        let userLikeList = Array(success)
////                        new.likeState = userLikeList.contains(where: { $0.id == item.productId })
////                    }
////                    if case .failure(let failure) = model {
////                        realmErrorTrigger.send(failure)
////                        strongSelf.output.realmIsError = true
////                    }
////                    return new
////                }))
////
////                currentTotal = datas.count
////                dump(datas)
////
////                DispatchQueue.main.async {
////                    strongSelf.output.drawRowViewModel = datas
////                    strongSelf.output.total.send(shop.total)
////                }
////
////                print("전체 : ",shop.total)
////            })
////            .store(in: &cancellabel)
//
//
//
////        input.inputCurrentIndex
////            .filter({ current in
////                currentTotal - 5 < current
////            })
////            .sink { current in
////                var value = start.value
////                value += 1
////                start.send(value)
////            }
////            .store(in: &cancellabel)
////
////        input.likeStateChange
////            .sink {[weak self] item, _ in
////                guard let self else { return }
////               var models = output.drawRowViewModel
////                if item.likeState {
////                    print("좋아요 \(item.productNameProcess)")
//////                    UserDefaultManager.productId.insert(before.productId)
////                    let model = LikePostModel(
////                        postId: item.productId,
////                        title: item.productNameProcess,
////                        sellerName: item.mallNameProcess,
////                        postUrlString: item.imageProcess?.description ?? ""
////                    )
////                    repository.add(model)
////                } else {
////                    print("좋아요취소 \(item.productNameProcess)")
////                    let result = repository.findIDAndRemove(type: LikePostModel.self, id: item.productId)
//////                    UserDefaultManager.productId.remove(before.productId)
////                    if case .failure(let failure) = result {
////                        realmErrorTrigger.send(failure)
////                        output.realmIsError = true
////                    }
////                }
////                models[index] = item
////                output.drawRowViewModel = models
////            }
////            .store(in: &cancellabel)
        
//    }
