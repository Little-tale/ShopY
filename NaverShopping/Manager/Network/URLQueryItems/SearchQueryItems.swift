//
//  SearchQueryItems.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation

struct SearchQueryItems {
    let searchText: String
    let display: Int
    let start: Int
    let sort: String
    
    func urlItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "query", value: searchText),
            URLQueryItem(name: "display", value: String(display)),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "sort", value: sort)
        ]
    }
}
