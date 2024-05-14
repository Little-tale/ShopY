//
//  RealmRepository.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift


protocol RealmRepositoryType {
    func fetchAll<M: Object>(type modelType: M.Type) -> Result<Results<M>,RealmError>
    
    func add<M:Object>(_ model: M) -> Result<M,RealmError>
    
    func remove(_ model: Object) -> Result<Void,RealmError>
}

final class RealmRepository: RealmRepositoryType {
   
    private
    var realm: Realm? {
        do {
            return try Realm()
        }
        catch {
            return nil
        }
    }
    
    func fetchAll<M>(type modelType: M.Type) -> Result<RealmSwift.Results<M>, RealmError> where M : Object {
        guard let realm else { return .failure(.cantLoadRealm)}
        
        return .success(realm.objects(modelType))
    }
   
    func add<M>(_ model: M) -> Result<M, RealmError> where M : Object {
        guard let realm else { return .failure(.cantLoadRealm)}
        do {
            try realm.write {
                realm.add(model)
                
            }
            return .success(model)
        } catch {
            return .failure(.failAdd)
        }
    }
    
    func remove(_ model: RealmSwift.Object) -> Result<Void, RealmError> {
        guard let realm else { return .failure(.cantLoadRealm)}
        do {
            try realm.write {
                realm.delete(model)
            }
            return .success(())
        } catch {
            return .failure(.failRemove)
        }
    }
    
}
