//
//  Interfacer.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation
import UIKit

protocol InterFacers { }

extension InterFacers where Self: AnyObject {
    
    func Interfaced(_ apply: (Self) -> Void) {
        apply(self)
    }
    
    func Interfaced(_ apply: (Self) -> Void) -> Self {
        apply(self)
        return self
    }
}

extension NSObject: InterFacers { }
extension Array: InterFacers { }
extension Dictionary: InterFacers { }
extension Set: InterFacers { }



