//
//  Interfacer.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

protocol Interfacer { }

extension Interfacer where Self: AnyObject {
    
    func Interfaced(_ apply: (Self) -> Void) {
        apply(self)
    }
    
    func Interfaced(_ apply: (Self) -> Void) -> Self {
        apply(self)
        return self
    }
}
