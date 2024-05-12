//
//  MVIPatternType.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/13/24.
//

import Combine

protocol MVIPatternType: ObservableObject {
    associatedtype InputAction
    
    associatedtype StateModel
}
