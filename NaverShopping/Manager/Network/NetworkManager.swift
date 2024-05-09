//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine


struct NetworkManager {
    
    typealias FetchType<T: Decodable> = AnyPublisher<T,NetworkError>
    
}

extension NetworkManager {
    
    static func fetchNetwork<T:Decodable>(model: T.Type, router: NaverRouter) -> FetchType<T> {
        Future<T, NetworkError> { promiss in
            Task {
                do {
                    let urlRequest =  router.asURLRequest()
                    guard case .success(let success) = urlRequest else {
                        return promiss(.failure(NetworkError.failRequest))
                    }
                    let (data, response) = try await URLSession.shared.data(for: success)
                    
                    guard let response = response as? HTTPURLResponse else {
                        return promiss(.failure(.noResponse))
                    }
                    
                    if !(200..<300).contains(response.statusCode) {
                        promiss(.failure(.cantStatusCoding))
                    }
                    
                    let decoding = try JSONDecoder().decode(T.self, from: data)
                    promiss(.success(decoding))
                    
                } catch {
                    promiss(.failure(.unknownError))
                }
            }
        }.eraseToAnyPublisher()
        
    }
    
}
