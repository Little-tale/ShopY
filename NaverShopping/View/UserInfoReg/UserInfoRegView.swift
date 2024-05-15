//
//  UserInfoRegView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/11/24.
//

import SwiftUI
import PhotosUI

enum UserProfileType {
    case first
    case modify
}

struct UserInfoRegView: View {
    
    @State
    var selectedImage: [UIImage] = []
    @State
    var galleryAlert: Bool = false
    
    var viewType: UserProfileType
    
    @StateObject private
    var viewModel = UserInfoRegViewModel()
    
    @State
    var goGallery: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("프로필을 등록해주세요")
                    .font(.title2)
                    .bold()
                
                profileView
                    .padding(.vertical, 20)
                
                ProfileTextField(headLine: "NAME *", placeHolder: "이름을 입력해 주세요 (필수)", text: Binding(
                    get: { viewModel.stateModel.nameText},
                    set: { viewModel.handle(intent: .nameText($0))})
                )
                .padding(.horizontal, 40)
                
                ProfileTextField(headLine: "Read Me", placeHolder: "자기소개를 작성해주세요", text: Binding(
                    get: { viewModel.stateModel.introduce},
                    set: { viewModel.handle(intent: .introduce($0))})
                )
                .padding(.horizontal, 40)
                
                ProfileTextField(headLine: "Phone Number", placeHolder: "전화번호를 입력해주세요", text: Binding(
                    get: { viewModel.stateModel.phoneNumber},
                    set: { viewModel.handle(intent: .phoneNumber($0))})
                )
                .padding(.horizontal, 40)
            
                
                Spacer()
            }
        }
    }
    
    
}

extension UserInfoRegView {
    var profileView: some View {
        MyProfileImageView(imageState:  $viewModel.imagePickerState)
        .asButton {
            goGallery = true
        }
        .buttonStyle(UserProfileImageButtonStyle())
        .fullScreenCover(isPresented: $goGallery) {
            CustomPhotoPicker(
                isPresented: $goGallery,
                selectedImages: { images in
                    viewModel.handle(intent: .selectImages(images))
                },
                selectedLimit: 1,
                filter: .images
            )
        }
        .onChange(of: selectedImage) { _, newValue in
            print(newValue)
        }
    }
}






struct UserProfileImageButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tint(.black)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#Preview {
    UserInfoRegView(viewType: .first)
}
