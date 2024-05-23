//
//  ApplePhotoPicker.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

/*
 해당 코드는 APPLE 에서 제공하는 샘플 코드를
 분석하는 란 입니다.
 */

//import SwiftUI // 기본이지
//import PhotosUI // 사진 프레임워크 아는거 :)
//import Combine
//
//@MainActor // 클래스의 모든 인스턴스는 메인쓰레드(Actor) 에서 접근 됨을 명시
//final class ProfileModel: MVIPatternType {
//
//    enum InputAction {
//        case firstnameChanged(String)
//        case lastNameChanged(String)
//        case aboutMeChanged(String)
//        case saveProfile
//    }
//
//    // MARK: 프로필 디테일
//    // Input 구조체
//    struct StateModel {
//        var firstName: String = ""
//        var lastName: String = ""
//        var aboutMe: String = ""
//        var saveButtonState: Bool {
//            firstName.count >= 2 && lastName.count >= 2
//        }
//    }
//    
//    private
//    var cancellables: Set<AnyCancellable> = []
//    
//    @Published private(set)
//    var state: StateModel = StateModel()
//    
//    func send(_ action: InputAction) {
//        switch action {
//        case .firstnameChanged(let string):
//            state.firstName = string
//            
//        case .lastNameChanged(let string):
//            state.lastName = string
//            
//        case .aboutMeChanged(let string):
//            state.aboutMe = string
//            
//        case .saveProfile:
//            print("저장 해야할 시점")
//        }
//    }
//    
//    /// 이미지 상태를 알려줍니다.
//    @Published private(set)
//    var imageState: ImageState = .empty
//    
//    enum TransforError: Error {
//        case importError // 이미지 로드 실패시 사용될 에러타입
//    }
//    
//    struct ProfileImage: Transferable {
//        let image: Image
//        
//        static var transferRepresentation: some TransferRepresentation {
//            DataRepresentation(importedContentType: .image) { data in
//                guard let uiImage = UIImage(data: data) else {
//                    throw TransforError.importError
//                }
//                let image = Image(uiImage: uiImage)
//                return ProfileImage(image: image)
//            }
//        }
//    }
//    
//    @Published
//    var imageSelection: PhotosPickerItem? = nil {
//        didSet {
//            if let imageSelection {
//               let progress = loadTransferable(from: imageSelection)
//                imageState = .loading(progress)
//            } else {
//                imageState = .empty
//            }
//        }
//    }
//    
//    private
//    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
//        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
//            DispatchQueue.main.async { [weak self] in
//                guard imageSelection == self?.imageSelection else {
//                    self?.imageState = .empty
//                    return
//                }
//                switch result {
//                case .success(let profileImage?):
//                    self?.imageState = .success(profileImage.image)
//                case .success(nil):
//                    self?.imageState = .empty
//                case .failure(let error):
//                    self?.imageState = .failure(error)
//                }
//            }
//            
//        }
//    }
//    
//}
