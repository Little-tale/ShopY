//
//  RealmRepository.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import Foundation
import RealmSwift


protocol RealmRepositoryType: AnyObject {
    func fetchAll<M: Object>(type modelType: M.Type) -> Result<Results<M>,RealmError>
    
    @discardableResult
    func add<M:Object>(_ model: M) -> Result<M,RealmError>
    
    func remove(_ model: Object) -> Result<Void,RealmError>
    
    func findById<M: Object & RealmFindType>(type modelType: M.Type, id: M.ID) -> Result< M? , RealmError>
}

protocol RealmFindType {
    
    associatedtype ID: Equatable
    
    var id: ID { get set }
    
}
/* 트러블 이슈 발생
 iOS 15 로 실행시 Realm Swift 뻗는 현상 발생 ->
 Thread 1: EXC_BAD_ACCESS (code=1, address=0x0)
 
 1. Realm Swift 지원 버전 확인 하였으나 문제 없음
 2. Realm Swift 버전을 변경
    2.1) 10.46.0 -> X
    2.2) 10.48.0 -> X
 3. 문제가 발생
 */

final class RealmRepository: RealmRepositoryType {
   
    private
    var realm: Realm?
    
    
    static func registerRealmClass() {
        let classes: [Object.Type] = [
            LikePostModel.self,
            ProfileRealmModel.self
        ]
        let config = Realm.Configuration(objectTypes: classes)
        Realm.Configuration.defaultConfiguration = config
    }
    
    init() {
        if #available(iOS 17, *) {
            
        } else {
            RealmRepository.registerRealmClass()
        }
        
        do {
            let realms = try Realm()
            realm = realms
            print(realm?.configuration.fileURL)
        } catch {
            print("렘 자체 문제 ")
            realm = nil
        }
//        realm = try! Realm()
    }
    
    func fetchAll<M>(type modelType: M.Type) -> Result<RealmSwift.Results<M>, RealmError> where M : Object {
        guard let realm else { return .failure(.cantLoadRealm)}
        
        return .success(realm.objects(modelType))
    }
   
    @discardableResult
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
    
    func remove(_ model: Object) -> Result<Void, RealmError> {
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
    
    func removeAllObject(complite: @escaping (Result<Void, RealmError>) -> Void ) {
        guard let realm else { complite(.failure(.cantLoadRealm)); return }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
            complite(.success(()))
        } catch {
            complite(.failure(.failRemove))
        }
    }
    
    func findById<M>(type modelType: M.Type, id: M.ID) -> Result< M? , RealmError> where M: Object & RealmFindType {
        guard let realm else { return .failure(.cantLoadRealm) }
        
        let object = realm.objects(modelType).where { $0.id == id }.first
        
        return .success(object)
    }
    
    func findIDAndRemove<M>(type modelType: M.Type, id: M.ID) -> Result<Void, RealmError> where M: Object & RealmFindType{
        guard let realm else { return .failure(.cantLoadRealm) }
        
        let findResult = findById(type: modelType, id: id)
        
        switch findResult {
        case .success(let success):
            
            guard let success else { return .failure(.cantFindModel)}
            
            return remove(success)
        case .failure(let failure):
            return .failure(.cantFindModel)
        }
    }
}

// RealmProfile
extension RealmRepository {
    
    func profileModify(
        id: String,
        name: String? = nil,
        introduce: String? = nil,
        phoneNumber: String? = nil,
        userImageUrl: String? = nil
    ) -> Result<Void, RealmError> {
        guard let realm else {
            return .failure(.cantLoadRealm)
        }
        
        var value = [String: Any]()
        
        value["profileId"] = try? ObjectId(string: id)
        
        if let name {
            value["name"] = name
        }
        if let introduce {
            value["introduce"] = introduce
        }
        if let phoneNumber {
            value["phoneNumber"] = phoneNumber
        }
        if let userImageUrl {
            value["userImageUrl"] = userImageUrl
        }
        
        
        do {
            try realm.write {
                realm.create(
                    ProfileRealmModel.self,
                    value: value,
                    update: .modified
                )
            }
            return .success(())
        } catch {
            return .failure(.failAdd)
        }
    }
    
}
