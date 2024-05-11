//
//  ImagePicker.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import Foundation
import PhotosUI
import Photos
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    let configuration: PHPickerConfiguration
    
    @State
    var photoImages: [UIImage] = []
    
    @Binding
    var isPresented: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
            parent.isPresented = false
            
            guard !results.isEmpty else {
                return
            }
            
            for result in results {
                let itemProvidor = result.itemProvider
                if itemProvidor.canLoadObject(ofClass: UIImage.self) {
                    itemProvidor.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        self?.parent.photoImages.append(image as! UIImage)
                    }
                }
            }
        }
        
    }
}
