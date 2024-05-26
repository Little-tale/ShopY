//
//  ProfileSettingView.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/24/24.
//

import SwiftUI

struct ProfileSettingView: View {
    
    @State // 임시
    var imageSate: ImagePickState = .empty
    
    @State
    var imageTrigger = false
    
    @StateObject
    private var viewModel = ProfileViewModel()
    
    var body: some View {
        Group {
            if #available(iOS 16, *){
                iOS16View
            } else {
                iOS15View
            }
        }
        .onAppear {
            viewModel.send(action: .viewOnAppear)
        }
        .alert("Error", isPresented: $viewModel.stateModel.ifError) {
            
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


extension ProfileSettingView {
    
    @available(iOS 16, *)
    var iOS16View: some View {
        NavigationStack {
            
            profileInfoView
                .padding(.all, 10)
            List {
                ForEach(ProfileViewModel.SettingSeciton.allCases, id: \.self) { at in
                    Text(ProfileViewModel.SettingSeciton.allCases[at.rawValue].title)
                        .listRowBackground(JHColor.white)
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
           
        }
    }
    
    var iOS15View: some View {
        NavigationView {
            VStack {
                profileInfoView
                    .padding(.all, 10)
                List {
                    ForEach(ProfileViewModel.SettingSeciton.allCases, id: \.self) { at in
                        
                        Text(ProfileViewModel.SettingSeciton.allCases[at.rawValue].title)
                            .listRowBackground(JHColor.white)
                    }
                }
                .navigationTitle("프로필")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(JHColor.pointGreen.opacity(0.2))
                )
               
            }
        }
    }
    
    private
    var navButtonView: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "gearshape")
            })
        }
    }
}


extension ProfileSettingView {
    
    private
    var profileInfoView: some View {
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
