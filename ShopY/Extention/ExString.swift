//
//  ExString.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

/*
 회고 직접 지워줄 필요가 없다.
 
  -> 이전
 var rmHTMLBold: String {
     
     let first = self.replacingOccurrences(of: "<b>", with: "")
     let results = first.replacingOccurrences(of: "</b>", with: "")
     return results
 }
 
  -> 후
 
 */

extension String {
    
    typealias ReadingOption = NSAttributedString.DocumentReadingOptionKey
    typealias DocumentType = NSAttributedString.DocumentType
    
    var rmHTMLTag: String {
        guard let data = self.data(using: .utf8) else { return self}
        let options: [ReadingOption : Any] = [
            .documentType: DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attrubuted = try NSAttributedString(
                data: data,
                options: options,
                documentAttributes: nil)
            
            return attrubuted.string
        } catch {
            return self
        }
    }
    
}
