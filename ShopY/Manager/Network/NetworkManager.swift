//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine


protocol NetworkManagerType {
    
    typealias FetchType<T: Decodable> = AnyPublisher<T,NetworkError>
    
    static func fetchNetwork<T:Decodable>(model: T.Type, router: NaverRouter) -> FetchType<T>
    
    static func checkReqeust<T: Decodable>(type: T.Type, router: NaverRouter) async throws -> T
    
    static func checkURLRequest(router: NaverRouter) throws -> URLRequest
    
    static func checkURLResponse(response: URLResponse) throws
    
    static func decode<T: Decodable>(data: Data) throws -> T
}

struct NetworkManager: NetworkManagerType { }

extension NetworkManager {
    
    static func fetchNetwork<T:Decodable>(model: T.Type, router: NaverRouter) -> FetchType<T> {
        
        Future<T, NetworkError> { promiss in
            Task {
                do {
                    let result = try await checkReqeust(type: model, router: router)
                    promiss(.success(result))
                } catch let error as NetworkError {
                    promiss(.failure(error))
                } catch {
                    promiss(.failure(.unknownError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func checkReqeust<T: Decodable>(type: T.Type, router: NaverRouter) async throws -> T {
        
        let urlRequest = try checkURLRequest(router: router)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        try checkURLResponse(response: response)
        
        return try decode(data: data)
    }
    
    static func checkURLRequest(router: NaverRouter) throws -> URLRequest {
        
        let urlRequest =  router.asURLRequest()
        
        guard case .success(let success) = urlRequest else {
            throw NetworkError.failRequest
        }
        
        return success
    }
    
    // CHECK  URLResponse
    static func checkURLResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.cantStatusCoding
        }
    }
    
    // Decode Method
    static func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let decoding = try JSONDecoder().decode(T.self, from: data)
            return decoding
        } catch {
            print( "errorDecoding Error ")
            throw NetworkError.errorDecoding
        }
    }
}

