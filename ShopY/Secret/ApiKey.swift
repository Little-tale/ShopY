//
//  ApiKey.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

enum APIKey{
    static let naverClientId = "ktooJv5hNiBnw8cn6GnK"
    static let naverClientSecret = "q_bfVW9CaB"
    
    static var getHeader: () -> [String : String] = {
        ["X-Naver-Client-Id" : APIKey.naverClientId,
         "X-Naver-Client-Secret" : APIKey.naverClientSecret ]
    }
}
