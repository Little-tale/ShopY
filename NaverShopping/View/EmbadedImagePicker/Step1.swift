//
//  Step1.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI

// 뷰모델을 만들어 봅시다.
@MainActor
final class ContentViewModel: ObservableObject {
    
    // 사용자가 선택한 이미지를 관리할 클래스
    @MainActor
    final class ImageAttachment: ObservableObject, Identifiable {
        
        enum Status {
            case loading // 로딩중
            case success(Image) // 사진 로드 했을때
            case failed(Error) // 실패시
            
            var isFailed: Bool {
                return switch self {
                case .failed: true
                default : false
                }
            }
        }
        
        enum LoadingError: Error {
            case contentTypeNotSupport
        }
        
        private
        let pickerItem: PhotosPickerItem
        
        @Published
        var imageStatus: Status?
        
        @Published
        var imageDescription: String = ""
        
        nonisolated // 데이터 동시 접근 방지.
        var id: String {
            return pickerItem.identifier
        }
        
        init(_ pickerItem: PhotosPickerItem) {
            self.pickerItem = pickerItem
        }
        
        func loadImage() async {
            guard imageStatus == nil || imageStatus?.isFailed == true else {
                return
            }
            imageStatus = .loading
            
            do {
                if let data = try await pickerItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    imageStatus = .success(Image(uiImage: uiImage))
                }
            } catch(let error) {
                imageStatus = .failed(error)
            }
        }
    }
    
    
    @Published
    var selection: [PhotosPickerItem] = [] {
        didSet {
            let new = selection.map { item in
                attachmentByIdentifier[item.identifier] ?? ImageAttachment(item)
            }
            
            let newIdenti = new.reduce(into: [:]) { partialResult, attach in
                partialResult[attach.id] = attach
            }
            
            attachments = new
            attachmentByIdentifier = newIdenti
        }
    }
    
    @Published
    var attachments: [ImageAttachment] = []
    
    private
    var attachmentByIdentifier = [String: ImageAttachment]()
}

private 
extension PhotosPickerItem {
    var identifier: String {
        guard let identifier = itemIdentifier else {
            fatalError("아이덴티 파이어 에러")
        }
        return identifier
    }
}
