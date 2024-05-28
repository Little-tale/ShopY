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
    
    var navigationTitle: String {
        switch self {
        case .first:
            return "등록하기"
        case .modify:
            return "수정하기"
        }
    }
}

struct UserInfoRegView: View {
    
    // Dismiss
    @Environment(\.dismiss) private var dismiss
    
    @State
    var selectedImage: [UIImage] = []
    @State
    var galleryAlert: Bool = false
    
    var viewType: UserProfileType
    
    @StateObject private
    var viewModel = UserInfoRegViewModel()
    
    @State
    var goGallery: Bool = false
    
    
    var ifNeedTrigger: (() -> Void)?
    
    var body: some View {
        
        VStack {

            Text(viewType == .first ? "프로필을 등록해 주세요" : "프로필 수정 하기")
                .font(.title2)
                .bold()
                .padding(.top, 15)
            
            profileView
                .padding(.top, 10)
                .padding(.bottom, 20)
            
            ProfileTextField(headLine: "NAME *", placeHolder: "이름을 입력해 주세요 (필수)",
                             text: Binding(
                                get: { viewModel.stateModel.nameText},
                                set: { viewModel.handle(intent: .nameText($0))}
                             ),
                             state: viewModel.stateModel.nameTextValid
            )
            .padding(.horizontal, 40)
            
            HStack{
                Spacer()
                Text(viewModel.stateModel.nameTextValid ? " " : "이름 형식이 맞지 않아요...")
                    .modifier(WarningTextViewModifier())
            }
            .padding(.trailing, 40)
            
            ProfileTextField(headLine: "Read Me", placeHolder: "자기소개를 작성해주세요", text: Binding(
                get: { viewModel.stateModel.introduce},
                set: { viewModel.handle(intent: .introduce($0))}),
                             state: nil
            )
            .padding(.horizontal, 40)
            .padding(.bottom, 15)
            
            ProfileTextField(headLine: "Phone Number", placeHolder: "전화번호를 입력해주세요",
                             text: Binding(
                                get: { viewModel.stateModel.phoneNumber},
                                set: { viewModel.handle(intent: .phoneNumber($0))}
                             ),
                             state: viewModel.stateModel.phoneNumberValid
            )
            .keyboardType(.numberPad)
            .padding(.horizontal, 40)
            
            
            HStack{
                Spacer()
                Text(viewModel.stateModel.phoneNumberValid ? " " : "전화번호 양식이 맞지 않아요...")
                    .modifier(WarningTextViewModifier())
            }
            .padding(.trailing, 40)
            
            Text("저장")
                .font(.headline)
                .bold()
                .frame(width: 200, height: 15)
                .asButton {
                    viewModel.handle(intent: .saveButtonTap(()))
                }
                .buttonStyle(SaveButtonStyle(
                    buttonState: viewModel.stateModel.saveButtonEnabled
                ))
                .disabled(!viewModel.stateModel.saveButtonEnabled)
                .padding(.vertical, 30)
            
            Spacer()
        }
        .alert(
            "Error",
            isPresented: $viewModel.stateModel.errorTrigger) {
                Text("")
            } message: {
                Text(viewModel.stateModel.currentError?.message ?? "ERROR")
            }
            .alert("등록 성공!", isPresented: $viewModel.stateModel.successTrigger) {
                Button(action: {
                    ifNeedTrigger?()
                }, label: {
                    Text("확인")
                })
            }
            .alert("수정 성공!", isPresented: $viewModel.stateModel.modifySuccess) {
                Button {
                    dismiss()
                    ifNeedTrigger?()
                } label: {
                    Text("확인")
                }
            }
            .onAppear {
                viewModel.handle(
                    intent: .inputViewType(viewType)
                )
            }
            .navigationTitle(viewModel.stateModel.viewType.navigationTitle)
    }
}



extension UserInfoRegView {
    var profileView: some View {
        MyProfileImageView(
            imageState:  $viewModel.imagePickerState,
            frame: CGSize(width: 100, height: 100)
        )
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
            .onChange(of: selectedImage) { newValue in
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

