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
        case imageChanged([Data])
    }
    
    
    struct ProfileModel {
        var userName: String
        var userInfo: String
        var userPhoneNumber: String
        var userProfileState: ImagePickState = .empty
        
        var id: String
    }
    
    struct StateModel {
        var ifError: Bool = false
        var errorCase: viewError = .none
        var profileModel = ProfileModel(
            userName: "",
            userInfo: "",
            userPhoneNumber: "",
            id: ""
        )
    }
    
    enum viewError: ErrorMessageType {
        case none
        case realmError(RealmError)
        case imageFileManagerError(ImageFileManagerError)
        
        var message: String {
            switch self {
            case .none:
                return "개발자 실수"
            case .realmError(let error):
                return error.message
            case .imageFileManagerError(let error):
                return error.message
            }
        }
    }
    
    @Published
    var stateModel = StateModel()
    
}
// Intent Action
extension ProfileViewModel {
    
    func send(action: Intent) {
        switch action {
        case .viewOnAppear:
            findProfile()
        case .imageChanged(let datas):
            dataChanged(datas: datas)
        }
    }
}

// Processing
extension ProfileViewModel {
    
    
    private func findProfile() {
        let result = realmRepository.fetchAll(type: ProfileRealmModel.self)
        
        switch result {
        case .success(let models):
            guard let model = models.first else {

                stateModel.errorCase = .realmError(.cantFindModel)
                
                stateModel.ifError = true
                return
            }
            let profileModel = makeProfileModel(model: model)
            
            stateModel.profileModel = profileModel
            
        case .failure(let error):
            stateModel.errorCase = .realmError(error)
            stateModel.ifError = true
        }
    }
    
    
    private func makeProfileModel(
        model: ProfileRealmModel
    ) -> ProfileModel
    {
        var phoneNumber = model.phoneNumber
        if phoneNumber == "" {
            phoneNumber = "Empty"
        }
        var profileModel = ProfileModel(
            userName: model.name,
            userInfo: model.introduce,
            userPhoneNumber: "P: " + phoneNumber,
            id: model.id
        )
        
        if let url = URL(string: model.userImageUrl) {
            profileModel.userProfileState = .localUrl(url)
        }
        
        return profileModel
    }
    
    private func dataChanged(datas: [Data]) {
        guard let data = datas.first else {
            return
        }
        if !removeData() {
            return
        }
        
        if !saveData(data: data) {
            return
        }
        
    }
    
    private func saveData(data: Data) -> Bool {
        
        let result = ImageFileManager.shared.saveImageData(
            pngData: data,
            folderPath: .profile,
            fileId: stateModel.profileModel.id
        )
        
        switch result {
        case .success(let url):
            
            let result = realmRepository.profileModify(
                id: stateModel.profileModel.id,
                userImageUrl: url.absoluteString
            )
            
            if case .failure(let error) = result {
                stateModel.errorCase = .realmError(error)
            }
            
            return true
        case .failure(let error):
            
            stateModel.errorCase = .imageFileManagerError(error)
            stateModel.ifError = true
            return false
        }
    }
    
    private func removeData() -> Bool {

        let result = ImageFileManager.shared.removeImage(
            folder: .profile,
            id: stateModel.profileModel.id
        )

        switch result {
        case .success:
            let result = realmRepository.profileModify(
                id: stateModel.profileModel.id,
                userImageUrl: ""
            )
            
            if case .failure(let error) = result {
                stateModel.errorCase = .realmError(error)
                stateModel.ifError = true
            }
            return true
        case .failure(let error):
            stateModel.errorCase = .imageFileManagerError(error)
            stateModel.ifError = true
            return false
        }
    }
}


