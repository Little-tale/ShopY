
//  ImagePicker.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.


import PhotosUI
import SwiftUI

enum PhotoViewError {
    case cant
}

struct PhotoView: View {
    
    @State 
    var photoItems: [PhotosPickerItem] = []
    
    @State
    var selectedPhotos:[UIImage] = []
    
    @State
    var photoError: PhotoViewError? = nil
    
    var body: some View {
        VStack {
            if !selectedPhotos.isEmpty {
                ScrollView(showsIndicators: false) {
                    ForEach(selectedPhotos, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
            }
            
            PhotosPicker(selection: $photoItems, maxSelectionCount: 0, matching: .images) {
                Label("Select photos", systemImage: "photo")
            }
            .onChange(of: photoItems) { _, newValue in
                newValue.forEach { item in
                    Task {
                        do {
                            guard let data = try await item.loadTransferable(type: Data.self) else { return }
                            guard let image = UIImage(data: data) else { return }
                            selectedPhotos.append(image)
                        } catch {
                            photoError = .cant
                        }
                    }
                }
            }
        }
    }
}

/*
 
 newItems.forEach { item in
     Task {
         guard let data = try? await item.loadTransferable(type: Data.self) else { return }
         guard let image = UIImage(data: data) else { return }
         selectedPhotos.append(image)
     }
 }
 */
