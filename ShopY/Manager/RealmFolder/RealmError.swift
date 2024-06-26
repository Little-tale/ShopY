//
//  RealmError.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation

enum RealmError: Error {
    case cantLoadRealm
    case failAdd
    case failRemove
    case cantFindModel
}


extension RealmError: ErrorMessageType {
    var message: String {
        return switch self {
        case .cantLoadRealm:
            "렘 로드 에러"
        case .failAdd:
            "추가 에러"
        case .failRemove:
            "삭제 에러"
        case .cantFindModel:
            "모델을 찾을수 없음"
        }
    }
}
