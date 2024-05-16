//
//  ErrorProtocol.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/17/24.
//

import Foundation

protocol ErrorMessageType: Error {
    var message: String { get }
}
