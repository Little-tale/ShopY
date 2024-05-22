//
//  EntityProtocol.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import Foundation

protocol EntityType {
    var id: UUID { get }
    
    static func create(entity: Self)
    static func read(id: UUID) -> Self?
    static func update(entity: Self)
    static func delete(id: UUID)
}
