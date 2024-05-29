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
    
    enum HomeCategorySection: String, CaseIterable {
        
        // 검색 문자
        case shoes = "신발"
        case clothes = "옷"
        case electronicdevices = "Apple"
        case office = "사무용품"
        
        // 헤더 타이틀
        var headerTitle: String {
             return switch self {
             case .shoes:
                 "Shoes Rank"
             case .clothes:
                 "Clothing Rank"
             case .electronicdevices:
                 "Electronics Rank"
             case .office:
                 "Office Supplies"
             }
        }
        
        var imageName: String {
            return switch self {
            case .shoes:
                "Shose"
            case .clothes:
                "Shirts"
            case .electronicdevices:
                "Elec"
            case .office:
                "Items"
            }
        }
    }
    
    
    enum Intent {
        case onAppear
    }
    
    struct StateModel {
        let sort: SortCase = .sim // 고정
        let next = 1 // 고정
        var items: [HomeCategorySection: [ShopEntityModel]] = [:]
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
        }
    }
}

extension RankingViewModel {
    
    private func fetchAllSections() {
        let sectionPublish = HomeCategorySection.allCases.map { section in
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
                var items: [HomeCategorySection :  [ShopEntityModel] ] = [:]
                result.forEach { section, itemSection in
                    items[section] = itemSection
                }
                self?.stateModel.items = items
//                self?.objectWillChange.send()
            }
            .store(in: &cancelable)

        
    }
}


