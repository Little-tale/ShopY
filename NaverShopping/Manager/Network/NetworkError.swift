//
//  NetworkError.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation

enum NetworkError: Error {
    case nodata
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
    case statusErrorCode
    case unknownError
}

extension NetworkError {
    
}
