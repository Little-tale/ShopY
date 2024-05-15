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
    
    @State
    var goGallery: Bool = false
    
    var body: some View {
        VStack {
            Text("프로필을 등록해주세요")
                .font(.title)
                .bold()
            HStack {
                if let image = selectedImage.first {
                    Image(uiImage: image)
                        .resizable()
                        .modifier(UserImageViewModifier())
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .modifier(UserImageViewModifier())
                }
            }
            .padding(.horizontal, 140)
            .asButton {
                print("이때 이미지 수정 알렛")
                goGallery = true
            }
            .buttonStyle(UserProfileImageButtonStyle())
            .fullScreenCover(isPresented: $goGallery) {
                CustomPhotoPicker(
                    isPresented: $goGallery,
                    selectedImages: $selectedImage,
                    selectedLimit: 1,
                    filter: .images
                )
            }
            .onChange(of: selectedImage) { _, newValue in
                print(newValue)
            }
            Spacer()
        }
    }
}
/*
 .confirmationDialog("테스트", isPresented: $galleryAlert) {
     Text("갤러리")
         .asButton {
             
         }
 }
 */

struct UserImageViewModifier: ViewModifier {
    
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
