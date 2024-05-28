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
    case localUrl(URL)
    case failure(Error)
}

struct MyProfileImageView: View {
    
    @Binding
    var imageState: ImagePickState
    
    let frame: CGSize
    
   // var count = 0
    
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
            case .localUrl(let url):
                urlMode(url: url)
                    .foregroundStyle(.white)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }
        }
        .modifier(CircularProfileImage(frame: frame))
        .onAppear {
            print("imageState: \(imageState) ")
        }
    }
    
}

extension MyProfileImageView {
    func urlMode(url: URL) -> some View {
        let image: UIImage?
        print("현 2: ",url)
        if #available(iOS 16, *) {
            print("++",url.path())
            
            image = UIImage(contentsOfFile: url.path())
        } else {
            image = UIImage(contentsOfFile: url.path)
        }
        
        guard let image else {
            return Image(systemName: "xmark")
        }
        
        return Image(uiImage: image)
            .resizable()
    }
}
