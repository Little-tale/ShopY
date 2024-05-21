//
//  SplashVIew.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/11/24.
//

import SwiftUI

struct SplashView: View {
    
    @State
    var isNextBool = false
    
    var body: some View {
        if #available(iOS 16, *){
            iOS16View
        } else {
            iOS15View
        }
    }
}


extension SplashView {
    // IOS 16*
    @ViewBuilder @available( iOS 16, *)
    var iOS16View: some View {
        NavigationStack {
            contentView
            .navigationDestination(
                isPresented: $isNextBool
            ) {
                UserInfoRegView(viewType: .first)
            }
        }
    }
    // IOS 15
    var iOS15View: some View {
        NavigationView {
            contentView
                .background(
                    NavigationLink(destination: {
                        UserInfoRegView(viewType: .first)
                    }, label: {
                        EmptyView()
                    })
                )
        }
    }
}

extension SplashView {
    private
    var contentView: some View {
        VStack(spacing: 10) {
            Image(systemName: "star")
                .resizable()
                .modifier(SplashImageModifier())
                .padding(.top, 40)
            
            Text("Speedy S")
                .font(.system(size: 40, weight: .bold, design: .default))
            
            
            Text("심플 쇼핑앱")
                .font(.title3)
            
            Spacer()
            
            StartButtonView
        } // Vstack
    }
}

extension SplashView {
    private
    var StartButtonView: some View {
        HStack {
            Text("시작하기")
                .font(JHFont.startFont)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .asButton {
                    isNextBool = true
                }
                .buttonStyle(StartButtonStyle())
        } // HStack
        .padding(.horizontal, 40)
        .padding(.bottom, 70)
    }
}

struct StartButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(JHColor.white)
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(JHColor.likeColor)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}





#Preview {
    SplashView()
}
