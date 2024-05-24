//
//  ProfileViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/24/24.
//

import Foundation

final class ProfileViewModel: MVIPatternType {
    
    enum SettingSeciton: Int, CaseIterable {
        case changedInfo
        case likeBasket
        
        var title: String {
            return switch self {
            case .changedInfo:
                "정보 변경"
            case .likeBasket:
                "찜 리스트"
            }
        }
    }
    
    enum Intent {
        
    }
    
    struct StateModel {
        let imageSate: ImagePickState = .empty
    }
    
    var stateModel = StateModel()
    
    
}
