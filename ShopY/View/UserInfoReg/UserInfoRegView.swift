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
    
    @FocusState private var isFocosed: Bool
    
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
        ZStack {
            VStack {

                Text(viewType == .first ? Const.AppText.profileRegMent : Const.AppText.profileModifyMent)
                    .font(.title2)
                    .bold()
                    .padding(.top, 15)
                
                profileView
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                
                ProfileTextField(headLine: Const.AppText.profileHead, placeHolder: Const.AppText.nameInfoMent,
                                 text: Binding(
                                    get: { viewModel.stateModel.nameText},
                                    set: { viewModel.handle(intent: .nameText($0))}
                                 ),
                                 state: viewModel.stateModel.nameTextValid
                )
                .padding(.horizontal, 40)
                .focused($isFocosed)
                
                HStack{
                    Spacer()
                    Text(viewModel.stateModel.nameTextValid ? " " : Const.AppText.nameUnValid)
                        .modifier(WarningTextViewModifier())
                }
                .padding(.trailing, 40)
                
                ProfileTextField(headLine: Const.AppText.introduceHead, placeHolder: Const.AppText.introduceMent, text: Binding(
                    get: { viewModel.stateModel.introduce},
                    set: { viewModel.handle(intent: .introduce($0))}),
                                 state: nil
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 15)
                .focused($isFocosed)
                
                ProfileTextField(headLine: Const.AppText.phoneNumberHead, placeHolder: Const.AppText.phoneNumberInfoMent,
                                 text: Binding(
                                    get: { viewModel.stateModel.phoneNumber},
                                    set: { viewModel.handle(intent: .phoneNumber($0))}
                                 ),
                                 state: viewModel.stateModel.phoneNumberValid
                )
                .keyboardType(.numberPad)
                .padding(.horizontal, 40)
                .focused($isFocosed)
                
                HStack{
                    Spacer()
                    Text(viewModel.stateModel.phoneNumberValid ? " " : Const.AppText.PhoneNumberUnValid)
                        .modifier(WarningTextViewModifier())
                }
                .padding(.trailing, 40)
                
                Text(Const.AppText.saveMent)
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
                .alert(Const.AppText.regSuccess, isPresented: $viewModel.stateModel.successTrigger) {
                    Button(action: {
                        ifNeedTrigger?()
                    }, label: {
                        Text(Const.AppText.checkMent)
                    })
                }
                .alert(Const.AppText.modifySuccess, isPresented: $viewModel.stateModel.modifySuccess) {
                    Button {
                        dismiss()
                        ifNeedTrigger?()
                    } label: {
                        Text(Const.AppText.checkMent)
                    }
                }
                .onAppear {
                    viewModel.handle(
                        intent: .inputViewType(viewType)
                    )
                }
                .navigationTitle(viewModel.stateModel.viewType.navigationTitle)
        }
        .background(JHColor.white)
        .onTapGesture {
            isFocosed = false
        }
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
                print("선택된 이미지",newValue)
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

