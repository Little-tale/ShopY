//
//  UserProfileRegView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI


struct ProfileImage: View {
    
    let imageState: ProfileViewModel.ImageState
    
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
                image.resizable()
            case .failure(let error):
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }
        }
        .modifier(CircularProfileImage())
        
    }
}

struct CircularProfileImage: ViewModifier {
   
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient (
                        colors: [JHColor.likeColor, JHColor.pointGreen],
                        startPoint: .leading,
                        endPoint: .bottom
                    )
                )
            }
    }
}

