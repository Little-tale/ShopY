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
    var viewModel = ProfileModel()
    
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
                          text: 
                            Binding(
                                get: {viewModel.state.firstName},
                                set: {viewModel.send(.firstnameChanged($0))}
                            ),
                          prompt: Text("성") // placeHolder
                )
                TextField("Last Name",
                          text:
                            Binding(
                                get: {viewModel.state.lastName},
                                set: {viewModel.send(.lastNameChanged($0))}
                            ),
                          prompt: Text("이름")
                )
            }
            
            Section {
                TextField(
                    "About Me",
                    text: Binding(
                        get: {viewModel.state.aboutMe},
                        set: {viewModel.send(.aboutMeChanged($0))}
                    ),
                    prompt: Text("자기소개")
                )
            }
            
            HStack {
                Text("저장")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 100)
            .asButton {
                print("저장 버튼 탭")
            }
            .disabled(!viewModel.state.saveButtonState)
        }
        .navigationTitle("프로필")
    }
}
