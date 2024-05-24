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
    var imageAlertTrigger = false
    
    private
    let viewModel = ProfileViewModel()
    
    var body: some View {
        if #available(iOS 16, *){
            iOS16View
        } else {
            iOS15View
        }
    }
    
    init() {
        if #available(iOS 16.0, *) {
            // none
        } else {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().isScrollEnabled = false
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
            .toolbar {
                Spacer()
                navButtonView
            }
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
                .toolbar {
                    Spacer()
                    navButtonView
                }
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
                imageState: $imageSate,
                frame: CGSize(width: 60, height: 60)
            )
            .asButton {
                imageAlertTrigger.toggle()
            }
            VStack(alignment: .leading) {
                Spacer()
                Text("이름: 들어갈곳asdasdasdasdasdasdasdasdasdasdasdsa")
                    .lineLimit(1)
                    .font(JHFont.profileNameFont)
                Text("안녕하세요~ 자기소개 란입니다 자기소개 해주시면 감사드릴께요~!")
                    .lineLimit(2)
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
