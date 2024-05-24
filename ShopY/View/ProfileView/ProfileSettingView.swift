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
    
    var body: some View {
        if #available(iOS 16, *){
            iOS16View
        } else {
            iOS15View
        }
    }
}


extension ProfileSettingView {
    
    @available(iOS 16, *)
    var iOS16View: some View {
        NavigationStack {
            ScrollView {
                profileInfoView
                    .padding(.all, 10)
                    // .padding(.vertical, 10)
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Spacer()
                navButtonView
            }
        }
    }
    
    var iOS15View: some View {
        NavigationView {
            ScrollView {
                HStack {
                    profileInfoView
                }
                .navigationTitle("프로필")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: navButtonView)
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
