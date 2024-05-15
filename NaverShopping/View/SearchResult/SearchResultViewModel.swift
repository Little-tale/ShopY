//
//  SearchResultViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation
import Combine

final class SearchResultViewModel: CombineViewModelType {
    
    private
    let repository = RealmRepository()
    
    var cancellabel: Set<AnyCancellable> = []
    
    @Published
    var input = Input()
    
    @Published
    var output = Output()
    
    init(){
        transform()
    }
    
}

extension SearchResultViewModel {
    struct Input {
        var searchText = PassthroughSubject<String, Never> ()
        var inputSort = CurrentValueSubject<SortCase,Never> (.sim)
        var inputCurrentIndex = CurrentValueSubject<Int,Never> (0)
        var likeStateChange = PassthroughSubject<(ShopItem,Int),Never> ()
    }
    
    struct Output {
        var ifNetworkError = CurrentValueSubject<NetworkError?, Never> (nil)
        var drawRowViewModel: [ShopItem] = []
        var total = CurrentValueSubject<Int,Never> (0)
        var isError = false
        var realmError = PassthroughSubject<RealmError, Never> ()
        var realmIsError = false
    }
}

extension SearchResultViewModel {
    
    
    func transform() {
        
        var currentTotal = 0
        
        let searchQueryItems = PassthroughSubject<SearchQueryItems, Never> ()
        
        let display = CurrentValueSubject<Int, Never>(30)
        
        let start = CurrentValueSubject<Int, Never> (1)
        
        let realmErrorTrigger = PassthroughSubject<RealmError, Never> ()
        output.realmError = realmErrorTrigger
        
        // distinctUntilChanged
        let sort = input.inputSort
            .removeDuplicates(by: { lcase, rcase in
                lcase.name == rcase.name
            })
            .map {[weak self] sort in
                self?.output.drawRowViewModel.removeAll()
                start.send(1)
                return sort
            }
        
        input.searchText
            .combineLatest(sort, start, display)
            .map({ (text, sort, start, display) in
                return (text: text, sort: sort, start: start, display: display)
            })
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { combined in
                let query = SearchQueryItems(
                    searchText: combined.text,
                    display: combined.display,
                    start: combined.start,
                    sort: combined.sort.rawValue
                )
                searchQueryItems.send(query)
            }
            .store(in: &cancellabel)
        
        searchQueryItems
            .flatMap({ queryItems in
                print("쿼리 아이템 \(queryItems)")
                let result = NetworkManager.fetchNetwork(
                    model: Shop.self,
                    router: .search(
                        query: queryItems
                    )
                )
                dump(queryItems)
                return result
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] result in
                switch result {
                case .finished:
                    print("성공은 했어요!")
                    break
                case .failure(let error):
                    print("에러가 나요",error)
                    self?.output.isError = true
                    self?.output.ifNetworkError.send(error)
                }
            }, receiveValue: { [weak self] shop in
                print("성공한 모델이에여")
                guard let strongSelf = self else { return }
                
                var datas = strongSelf.output.drawRowViewModel
                
                datas.append(contentsOf: shop.items.map({ item in
                    var new = item
                    let model = strongSelf.repository.fetchAll(type: LikePostModel.self)
                    if case .success(let success) = model {
                        let userLikeList = Array(success)
                        new.likeState = userLikeList.contains(where: { $0.id == item.productId })
                    }
                    if case .failure(let failure) = model {
                        realmErrorTrigger.send(failure)
                        strongSelf.output.realmIsError = true
                    }
                    return new
                }))
                
                currentTotal = datas.count
                dump(datas)
                
                DispatchQueue.main.async {
                    strongSelf.output.drawRowViewModel = datas
                    strongSelf.output.total.send(shop.total)
                }
                
                print("전체 : ",shop.total)
            })
            .store(in: &cancellabel)
        
        
        
        input.inputCurrentIndex
            .filter({ current in
                currentTotal - 5 < current
            })
            .sink { current in
                var value = start.value
                value += 1
                start.send(value)
            }
            .store(in: &cancellabel)
        
        input.likeStateChange
            .sink {[weak self] item, index in
                guard let self else { return }
               var models = output.drawRowViewModel
                if item.likeState {
                    print("좋아요 \(item.productNameProcess)")
//                    UserDefaultManager.productId.insert(before.productId)
                    let model = LikePostModel(
                        postId: item.productId,
                        title: item.productNameProcess,
                        sellerName: item.mallNameProcess,
                        postUrlString: item.imageProcess?.description ?? ""
                    )
                    repository.add(model)
                } else {
                    print("좋아요취소 \(item.productNameProcess)")
                    let result = repository.findIDAndRemove(type: LikePostModel.self, id: item.productId)
//                    UserDefaultManager.productId.remove(before.productId)
                    if case .failure(let failure) = result {
                        realmErrorTrigger.send(failure)
                        output.realmIsError = true
                    }
                }
                models[index] = item
                output.drawRowViewModel = models
            }
            .store(in: &cancellabel)
        
    }
    
}
