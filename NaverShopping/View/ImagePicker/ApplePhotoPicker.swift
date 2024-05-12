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

import SwiftUI // 기본이지
import PhotosUI // 사진 프레임워크 아는거 :)

@MainActor // 클래스의 모든 인스턴스는 메인쓰레드(Actor) 에서 접근 됨을 명시
final class ProfileViewModel: ObservableObject {
    
    // MARK: 프로필 디테일
    @Published
    var firstName: String = ""
    
    @Published
    var lastName: String = ""
    
    @Published
    var aboutMe: String = ""
    
    /// 이미지 상태를 알려줍니다.
    @Published private(set)
    var imageState: ImageState = .empty
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransforError: Error {
        case importError // 이미지 로드 실패시 사용될 에러타입
    }
    
    struct ProfileImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransforError.importError
                }
                let image = Image(uiImage: uiImage)
                return ProfileImage(image: image)
            }
        }
    }
    
    @Published
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
               let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    private
    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async { [weak self] in
                guard imageSelection == self?.imageSelection else {
                    self?.imageState = .empty
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self?.imageState = .success(profileImage.image)
                case .success(nil):
                    self?.imageState = .empty
                case .failure(let error):
                    self?.imageState = .failure(error)
                }
            }
            
        }
    }
    
}
