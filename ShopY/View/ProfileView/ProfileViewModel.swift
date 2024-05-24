//
//  ProfileViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/24/24.
//

import Foundation

final class ProfileViewModel: MVIPatternType {
    
    enum Intent {
        
    }
    
    struct StateModel {
        let imageSate: ImagePickState = .empty
    }
    
    var stateModel = StateModel()
    
    
}
