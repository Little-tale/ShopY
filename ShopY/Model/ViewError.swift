//
//  ViewError.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/17/24.
//

import Foundation

enum ViewError: Error {
    case weakSelfError
}

extension ViewError: ErrorMessageType {
    
    var message: String {
        switch self {
        case .weakSelfError:
            return "예상치 못한 에러입니다. 관리자에 문의 바랍니다."
        }
    }
}
