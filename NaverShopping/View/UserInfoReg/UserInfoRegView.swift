//
//  UserInfoRegView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/11/24.
//

import SwiftUI
import PhotosUI

struct UserInfoRegView: View {
    
    @State
    var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("프로필 정하기")
                .font(.title)
                .bold()
            HStack {
                if let selectedImage {
                    Image(uiImage: selectedImage)
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
            }
            .buttonStyle(UserProfileImageButtonStyle())
            Spacer()
        }
        
    }
}

struct UserImageViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .clipShape(Circle(), style: FillStyle())
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
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
    UserInfoRegView()
}
