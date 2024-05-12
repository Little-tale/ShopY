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
}
