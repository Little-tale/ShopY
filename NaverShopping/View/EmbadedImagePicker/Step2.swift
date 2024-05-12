//
//  Step2.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI

struct Step2View: View {
    
    @StateObject
    private var viewModel = ContentViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageList(viewModel: viewModel)
                
                
                PhotosPicker(
                    selection: $viewModel.selection,
                    selectionBehavior: .continuousAndOrdered,
                    matching: .images,
                    preferredItemEncoding: .current,
                    photoLibrary: .shared()
                ) {
                    Text("흠....")
                }
                
                .photosPickerStyle(.compact)
                .photosPickerDisabledCapabilities(.selectionActions)
                .photosPickerAccessoryVisibility(.visible, edges: .all)
                .ignoresSafeArea()
                .frame(height: 300)
                
            }
        }
    }
}


struct ImageList: View {
    
    @ObservedObject
    var viewModel: ContentViewModel
    
    var body: some View {
        if viewModel.attachments.isEmpty {
            Spacer()
            Image(systemName: "star")
                .font(.system(size: 160))
                .opacity(0.4)

            Spacer()
        } else {
            List(viewModel.attachments) {
                imageAttach in
                ImageAttachmentView(
                    imageAttachment: imageAttach
                )
            }
        }
    }
}

struct ImageAttachmentView: View {

    @ObservedObject 
    var imageAttachment: ContentViewModel.ImageAttachment
    
    /// A container view for the row.
    var body: some View {
        HStack {
            
            TextField("Image Description", text: $imageAttachment.imageDescription)
            
            Spacer()
            
            switch imageAttachment.imageStatus {
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fit).frame(height: 100)
            case .failed:
                Image(systemName: "exclamationmark.triangle.fill")
            default:
                ProgressView()
            }
        }.task {
            // Asynchronously display the photo.
            await imageAttachment.loadImage()
        }
    }
}
