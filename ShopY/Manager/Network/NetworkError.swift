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
    
    // 임시로 에러를 정의합니다
    var errorMessgae: String {
        switch self {
        case .nodata:
            return "데이터 에러"
        case .noResponse:
            return "응답 에러 무"
        case .errorResponse:
            return "데이터 에러"
        case .failRequest:
            return "요청 실패"
        case .errorDecoding:
            return "디코딩 에러"
        case .cantStatusCoding:
            return "상태코드 실패"
        case .statusErrorCode:
            return "상태 코드 에러 (임시)"
        case .unknownError:
            return "알수없음"
        }
    }
}
