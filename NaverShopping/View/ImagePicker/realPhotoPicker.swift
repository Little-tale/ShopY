//
//  realPhotoPicker.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding
    var isPresented: Bool
    
    @Binding
    var selectedImages: [UIImage]
    
    /// 선택 가능한 개체 수
    let selectedLimit: Int // 선택 가능 이미지 갯수
    
    /// 미디어 타입 정해주세요
    let filter: PHPickerFilter
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = selectedLimit
        config.filter = filter
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages = []
            let dispatchGroup = DispatchGroup()
            
            for result in results {
                
                dispatchGroup.enter()
                
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    guard let image = object as? UIImage else {
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.parent.selectedImages.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) { [unowned self] in
                parent.isPresented = false
            }
        }
    }
}
