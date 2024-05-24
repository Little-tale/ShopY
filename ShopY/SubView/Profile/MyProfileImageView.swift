//
//  UserProfileImageView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import SwiftUI
import PhotosUI


enum ImagePickState {
    case empty
    case loading
    case success(UIImage)
    case failure(Error)
}

struct MyProfileImageView: View {
    
    @Binding
    var imageState: ImagePickState
    
    let frame: CGSize
    
    var body: some View {
        VStack {
            switch imageState {
            case .empty:
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            case .loading:
                ProgressView()
            case .success(let image):
                Image(uiImage: image)
                .resizable()
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }
        }
        .modifier(CircularProfileImage(frame: frame))
        .onAppear {
            print(" ....!!!! ")
        }
    }
    
}


