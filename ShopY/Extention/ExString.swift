//
//  ExString.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

extension String {
    
    var rmHTMLBold: String {
        let first = self.replacingOccurrences(of: "<b>", with: "")
        let results = self.replacingOccurrences(of: "</b>", with: "")
        return results
    }
}
