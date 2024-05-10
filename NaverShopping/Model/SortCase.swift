//
//  SortCase.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/10/24.
//

import Foundation

enum SortCase: String, CaseIterable {
    case sim
    case date
    case asc
    case dsc
    
    
    var name: String{
        switch self {
        case .sim:
            "정확도"
        case .date:
            "날짜순"
        case .asc:
            "저가순"
        case .dsc:
            "고가순"
        }
    }
}
