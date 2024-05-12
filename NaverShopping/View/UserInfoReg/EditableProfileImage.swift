//
//  EditableProfileImage.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI

struct EditableProfileImage: View {
    @ObservedObject
    var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $viewModel.imageSelection,
                matching: .images,
                photoLibrary: .shared()) {
                    ProfileImage(imageState: viewModel.imageState)
                }
                .paletteSelectionEffect(.automatic)
        }
    }
}
#Preview {
    EditableProfileImage(viewModel: .init())
}
