//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine

protocol TargetType {
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parametter: [ String: Any ]? { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    
// 시간상 생략
//    func errorCase(_ errorCode: Int, _ description: String) -> NetworkError
}

extension TargetType {
    
    func asURLRequest() -> Result<URLRequest, NetworkError> {
        
        let baseURL = URL(string: baseUrl)
        
        guard let baseURL else {
            return .failure(.errorResponse)
        }
        
        let url = baseURL.appendingPathComponent(path, conformingTo: .url)
        
        var urlCompponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        urlCompponents?.queryItems = queryItems
        
        guard let lastURL = urlCompponents?.url else {
            return .failure(.errorResponse)
        }
        
        var urlRequest = URLRequest(url: lastURL)
        print(method.rawValue)
        urlRequest.httpMethod = method.rawValue
        return .success(urlRequest)
        
    }
}



