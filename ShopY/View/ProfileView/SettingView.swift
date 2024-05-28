//
//  ProfileSettingView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/24/24.
//

import SwiftUI
/*
 회고 View On Appear 작동 안하는 이유
 
 */

struct SettingView: View {
    
    @State
    var imageTrigger = false
        
    @StateObject
    private var viewModel = SettingViewModel()
    
    @EnvironmentObject
    var navigationManager: RootViewModel
    
    var body: some View {
        Group {
            if #available(iOS 16, *){
                iOS16View
                    .onAppear {
                        
                        viewModel.send(action: .viewOnAppear)
                    }
            } else {
                iOS15View
                    .onAppear {
                        
                        viewModel.send(action: .viewOnAppear)
                    }
            }
        }
        .alert("Error",
               isPresented: $viewModel.stateModel.ifError
        ) {
            Text("???")
        } message: {
            alertMessage()
        }
        .fullScreenCover(isPresented: $imageTrigger) {
            CustomPhotoPicker(
                isPresented: $imageTrigger,
                selelectedDataForPNG: { datas in
                    viewModel.send(action: .imageChanged(datas))
                },
                selectedLimit: 1,
                filter: .images
            )
        }
        .onChange(of: viewModel.stateModel.moveToRootView) {  newValue in
            if newValue == true {
                navigationManager.send(action: .ifUserInfoReg)
            }
        }
    }
   
    
    func alertMessage() -> some View {
        let errorCase = viewModel.stateModel.errorCase
        return Text(errorCase.message)
    }
    
    init() {
        if #available(iOS 16.0, *) {
            // none
        } else {
            UITableView.appearance().backgroundColor = .clear
        }
    }
}


extension SettingView {
    
    @available(iOS 16, *)
    var iOS16View: some View {
        NavigationStack {
            
            profileInfoView
                .padding(.all, 10)
            List {
                ForEach(SettingViewModel.SettingSeciton.allCases, id: \.self) { at in
                    Button {
                        viewModel.send(action: .selectedCase(at))
                    } label: {
                        Text(SettingViewModel.SettingSeciton.allCases[at.rawValue].title)
                            .listRowBackground(JHColor.white)
                    }
                    .tint(JHColor.black)
                }
                .navigationDestination(isPresented: $viewModel.stateModel.moveToModifyView) {
                    UserInfoRegView(
                        viewType: .modify) {
                            viewModel.send(action: .viewOnAppear)
                        }
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(JHColor.pointGreen.opacity(0.2))
            )
            .navigationDestination(isPresented: $viewModel.stateModel.moveToLikes) {
                LikesView()
            }
            
        }
    }
    
    var iOS15View: some View {
        NavigationView {
            VStack {
                profileInfoView
                    .padding(.all, 10)
                List {
                    ForEach(SettingViewModel.SettingSeciton.allCases, id: \.self) { at in
                        Button {
                            viewModel.send(action: .selectedCase(at))
                        } label: {
                            Text(SettingViewModel.SettingSeciton.allCases[at.rawValue].title)
                                .listRowBackground(JHColor.white)
                        }
                        .tint(JHColor.black)
                    }
                }
                .navigationTitle("프로필")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(JHColor.pointGreen.opacity(0.2))
                )
                NavigationLink(isActive: $viewModel.stateModel.moveToLikes) {
                    LikesView()
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $viewModel.stateModel.moveToModifyView) {
                    UserInfoRegView(viewType: .modify) {
                        viewModel.send(action: .viewOnAppear)
                    }
                } label: {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


extension SettingView {
    
    private
    var profileInfoView: some View {
        VStack {
            HStack {
                MyProfileImageView(
                    imageState: $viewModel.stateModel.profileModel.userProfileState,
                    frame: CGSize(width: 60, height: 60)
                )
                .asButton {
                    imageTrigger.toggle()
                }
                VStack(alignment: .leading) {
                    Spacer()
                    Text(viewModel.stateModel.profileModel.userName)
                        .lineLimit(1)
                        .font(JHFont.profileNameFont)
                    Text(viewModel.stateModel.profileModel.userInfo)
                        .lineLimit(2)
                        .font(JHFont.introduceFont)
                    Text(viewModel.stateModel.profileModel.userPhoneNumber)
                        .font(JHFont.introduceFont)
                    Spacer()
                }
                .padding(.leading, 10)
                Spacer()
            }
            .frame(height: 120)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(JHColor.white)
                    .shadow(
                        color: JHColor.darkGray.opacity(0.5),
                        radius: 5,
                        x: 0,
                        y: 0
                    )
            )
        }
       
    }
}
