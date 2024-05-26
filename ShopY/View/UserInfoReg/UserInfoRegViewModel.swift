//
//  UserInfoRegViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import UIKit.UIImage
import Combine

// MARK: ViewModel
final class UserInfoRegViewModel: MVIPatternType {
    
    private
    var cancellable = Set<AnyCancellable> ()
    
    @Published
    var imagePickerState: ImagePickState = .empty
    
    @Published
    var stateModel = StateModel()
    
    private
    let repository = RealmRepository()
    
    private
    let errorCase = PassthroughSubject<ErrorType, Never> ()
    
    enum Intent { // 다시 학습해 보자. 사용자의 의도를 관리
        case selectImages([UIImage])
        case nameText(String)
        case introduce(String)
        case phoneNumber(String)
        case saveButtonTap(Void)
        
    }
    
    struct StateModel { // 상태를 담당
        var nameText = ""
        var introduce = ""
        var phoneNumber = ""
        var userImageUrl: String? = nil
        var saveButtonEnabled = false
        var successTrigger = false
        
        var currentError: ErrorType? = nil
        
        // TextValidState
        var nameTextValid = false
        var phoneNumberValid = true
        
        // ErrorTrigger
        var errorTrigger: Bool = false
    }
    
    enum ErrorType : ErrorMessageType {
        
        case realmError(RealmError)
        case imageError(ImageFileManagerError)
        case viewError(ViewError)
        
        var message: String {
            return switch self {
            case .realmError(let error):
                error.message
            case .imageError(let error):
                error.message
            case .viewError(let error):
                error.message
            }
        }
    }
    
    init(){
        errorCase
            .sink {[weak self] error in
                self?.errorCaseProcessing(error)
            }
            .store(in: &cancellable)
    }
    
}

// MARK: Intent Handle
extension UserInfoRegViewModel {
    
    func handle(intent: Intent) {
        switch intent {
        case .selectImages(let images):
            processingImage(images)
            
        case .nameText(let name):
            stateModel.nameText = name
            
            validTextForButton()
        case .introduce(let introduce):
            stateModel.introduce = introduce
            
        case .phoneNumber(let phoneNumber):
            stateModel.phoneNumber = phoneNumber
            
            validTextForButton()
            
        case .saveButtonTap:
            saveButtonTab()

        }
    }
}

// MARK: Processing
extension UserInfoRegViewModel {
    
    private
    func processingImage(_ images: [UIImage]) {
        if let firstImage = images.first {
            imagePickerState = .success(firstImage)
        } else {
            imagePickerState = .empty
        }
    }
    
    private
    func validTextForButton() {
        /// Name Valid
        stateModel.nameTextValid = TextValidTestManager.matchesPattern(
            .userName(
                text: stateModel.nameText
            )
        )
        
        /// phoneNumberValid Valid
        stateModel.phoneNumberValid = TextValidTestManager.matchesPattern(
            .phoneNumber(
                text: stateModel.phoneNumber
            )
        )

        // ButtonEnabled
        stateModel.saveButtonEnabled = stateModel.nameTextValid && stateModel.phoneNumberValid
    }
    
    private
    func saveButtonTab(){
        print("SaveButton Tab")
        let name = stateModel.nameText
        let introduce = stateModel.introduce
        let phoneNumber = stateModel.phoneNumber
        
        let model = ProfileRealmModel(
            name: name,
            phoneNumber: phoneNumber,
            introduce: introduce,
            userImageUrl: ""
        )
        
        if case .success(let image) = imagePickerState {
            saveImage(image, model: model) {[weak self] result in
                guard let weakSelf = self else {
                    self?.stateModel.currentError = .viewError(.weakSelfError)
                    return
                }
                switch result {
                case .success(let success):
                    weakSelf.saveModel(success)
                case .failure(let failure):
                    weakSelf.stateModel.currentError = .imageError(failure)
                }
            }
        } else {
            saveModel(model)
        }
    }
    
    private
    func saveImage(_ image: UIImage,
                   model: ProfileRealmModel,
                   handler: @escaping((Result<ProfileRealmModel,ImageFileManagerError>) -> Void)
    ) {
        
        let result = ImageFileManager.shared.saveImage(
            image: image,
            folderPath: .profile,
            fileId: model.id
        )

        switch result {
        case .success(let success):
            model.userImageUrl = success.absoluteString
            handler(.success(model))
        case .failure(let failure):
            handler(.failure(failure))
        }
    }
    
    private
    func saveModel(_ model: ProfileRealmModel) {
        let result =  repository.add(model)
        
        switch result {
        case .success:
            stateModel.successTrigger = true
        case .failure(let failure):
            stateModel.currentError = .realmError(failure)
        }
    }
    
    private
    func errorCaseProcessing(_ errorCase: ErrorType) {
        stateModel.currentError = errorCase
        stateModel.errorTrigger = true
    }
}
