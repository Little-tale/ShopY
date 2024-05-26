//
//  ProfileViewModel.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/24/24.
//

import Foundation

final class ProfileViewModel: MVIPatternType {
    
    private
    let realmRepository = RealmRepository()
    
    enum SettingSeciton: Int, CaseIterable {
        case changedInfo
        case likeBasket
        
        var title: String {
            return switch self {
            case .changedInfo:
                "정보 변경"
            case .likeBasket:
                "찜 리스트"
            }
        }
    }
    
    enum Intent {
        case viewOnAppear
        
    }
    
    struct ProfileModel {
        var userName: String
        var userInfo: String
        var userPhoneNumber: String
        var userImage: URL?
    }
    
    struct StateModel {
        var imageSate: ImagePickState = .empty
        var ifError: Bool = false
        var realmError: RealmError? = nil
        var profileModel = ProfileModel(
            userName: "",
            userInfo: "",
            userPhoneNumber: ""
        )
    }
    
    @Published
    var stateModel = StateModel()
    
}

extension ProfileViewModel {
    
    func send(action: Intent) {
        switch action {
        case .viewOnAppear:
            findProfile()
        }
    }
}

extension ProfileViewModel {
    
    private
    func findProfile() {
        let result = realmRepository.fetchAll(type: ProfileRealmModel.self)
        
        switch result {
        case .success(let models):
            guard let model = models.first else {
                stateModel.realmError = .cantFindModel
                stateModel.ifError = true
                return
            }
            let profileModel = makeProfileModel(model: model)
            
            stateModel.profileModel = profileModel
            
        case .failure(let error):
            stateModel.realmError = error
            stateModel.ifError = true
        }
    }
    
    private
    func makeProfileModel(
        model: ProfileRealmModel
    ) -> ProfileModel
    {
        var profileModel = ProfileModel(
            userName: model.name,
            userInfo: model.introduce,
            userPhoneNumber: model.phoneNumber,
            userImage: URL(string: model.userImageUrl)
        )
        
        return profileModel
    }
    
    
}


