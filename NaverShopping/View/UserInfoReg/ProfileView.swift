//
//  PrfofileView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/12/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ProfileForm()
        }
    }
}


struct ProfileForm: View {
    
    @StateObject
    var viewModel = ProfileViewModel()
    
    var body: some View {
        Form { // 컨테이너 뷰 ( 설정화면 같은 그런곳 )
            Section {
                HStack {
                    Spacer()
                    EditableProfileImage(viewModel: viewModel)
                    Spacer()
                }
                .listRowBackground(JHColor.gray)
                .padding([.top], 10)
            }
            Section {
                TextField("First Name", // Label (UI 접근성)
                          text: $viewModel.firstName,
                          prompt: Text("성") // placeHolder
                )
                TextField("Last Name",
                          text: $viewModel.lastName,
                          prompt: Text("이름")
                )
            }
            
            Section {
                TextField(
                    "About Me",
                    text: $viewModel.aboutMe,
                    prompt: Text("자기소개")
                )
            }
        }
        .navigationTitle("프로필")
    }
}

#Preview{
    ProfileView()
}
