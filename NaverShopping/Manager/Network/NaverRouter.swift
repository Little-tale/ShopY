//
//  SearchRouter.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation


enum NaverRouter {
    case search(searchText: String, query: SearchQueryItems)
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
        case .search(_, let query):
            return query.urlItems()
        }
    }

}
