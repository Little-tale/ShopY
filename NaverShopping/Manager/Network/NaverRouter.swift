//
//  SearchRouter.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation


enum NaverRouter {
    case search(query: SearchQueryItems)
}

extension NaverRouter: TargetType {
  
    
    var baseUrl: String {
        return "https://openapi.naver.com/v1/"
    }
    
    var path: String {
        switch self {
        case .search:
            return "search/shop.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parametter: [String : Any]? {
        return nil
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query):
            let edcoding = query.searchText.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "none"
            return [
                URLQueryItem(name: "query", value: edcoding),
                URLQueryItem(name: "display", value: String(query.display)),
                URLQueryItem(name: "start", value: String(query.start)),
                URLQueryItem(name: "sort", value: query.sort)
            ]
        }
    }
}
