//
//  SearchResultViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation
import Combine

final class SearchResultViewModel: CombineViewModelType {
    
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
    }
    
    struct Output {
        var ifNetworkError = CurrentValueSubject<NetworkError?, Never> (nil)
        var drawRowViewModel: [ShopItem] = []
        var total = CurrentValueSubject<Int,Never> (0)
        var isError = false
    }
}

extension SearchResultViewModel {
    
    
    func transform() {
        
        var currentTotal = 0
        
        let searchQueryItems = PassthroughSubject<SearchQueryItems, Never> ()
        
        let display = CurrentValueSubject<Int, Never>(30)
        
        let start = CurrentValueSubject<Int, Never> (1)
        
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
                var datas = self?.output.drawRowViewModel
                datas?.append(contentsOf: shop.items)
                currentTotal = datas?.count ?? 0
                dump(datas)
                DispatchQueue.main.async {
                    self?.output.drawRowViewModel = datas ?? []
                    self?.output.total.send(shop.total)
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
        
    }
    
}
