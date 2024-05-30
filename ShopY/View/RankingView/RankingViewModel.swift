//
//  RankingViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/29/24.
//

import Foundation
import Combine

/*
 Publishers.MergeMany
 회고
 */

final class RankingViewModel: MVIPatternType {
    
    private
    var cancelable = Set<AnyCancellable> ()
    
    enum Intent {
        case onAppear
    }
    
    struct StateModel {
        let sort: SortCase = .sim // 고정
        let next = 1 // 고정
        var items: [Const.RankingSection: [ShopEntityModel]] = [:]
        var bannerItems: [ShopEntityModel] = []
        var error: RankingError?
    }
    
    enum RankingError {
        case network(NetworkError)
    }
    
    @Published
    var stateModel = StateModel()
    
    private
    let itemRepository = ShopItemsRepository()
    
}

extension RankingViewModel {
        
    func send(action: Intent) {
        switch action {
            
        case .onAppear:
            fetchAllSections()
            fetchBannerData()
        }
    }
}

extension RankingViewModel {
    
    private func fetchAllSections() {
        let sectionPublish = Const.RankingSection.allCases.map { section in
            itemRepository.requestPost(
                search: section.rawValue,
                next: stateModel.next,
                sort: stateModel.sort
            )
            .map { (section , $0.models) }
            .catch { _ in
                Just((section, []))
            }
            .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(sectionPublish)
            .collect() // SingleArray
            .sink { complet in
                switch complet {
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                var items: [Const.RankingSection :  [ShopEntityModel] ] = [:]
                result.forEach { section, itemSection in
                    items[section] = itemSection
                }
                self?.stateModel.items = items
//                self?.objectWillChange.send()
            }
            .store(in: &cancelable)
    }
    
    private func fetchBannerData() {
        
        let result = itemRepository.requestPost(
            search: Const.RankingToBanner.appleSale,
            next: stateModel.next,
            sort: stateModel.sort
        )
        
        result
            .map({ $0.models })
            .catch {[weak self] error in
                self?.stateModel.error = .network(error)
                let empty = [ShopEntityModel] ()
                return Just(empty)
            }
            .sink { [weak self] models in
                print("데이터는 전달 받음 \(models)")
                self?.stateModel.bannerItems = models
            }
            .store(in: &cancelable)
    }
}


