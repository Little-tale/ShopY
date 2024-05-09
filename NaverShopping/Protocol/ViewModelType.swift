//
//  ViewModelType.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/9/24.
//

import Foundation
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    
    associatedtype Input
    
    associatedtype Output
    
    var input: Input { get }
    
    var output: Output { get }
    
    func transform()

}

