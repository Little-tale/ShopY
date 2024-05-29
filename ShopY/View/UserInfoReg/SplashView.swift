//
//  SplashView.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/22/24.
//

import SwiftUI


struct splashView: View {
    @State
    var isNextBool = false
    
    @EnvironmentObject var navigationManager: RootViewModel
    
    var body: some View {
        if #available(iOS 16, *){
            iOS16View
            
        } else {
            iOS15View
        }
    }
    
    init(){
        navigationStyle()
        navigationButtonStyle()
    }
}


extension splashView {
    // IOS 16*
    @available( iOS 16, *)
    var iOS16View: some View {
        NavigationStack {
            contentView
            .navigationDestination(
                isPresented: $isNextBool
            ) {
                UserInfoRegView(viewType: .first) {
                    navigationManager.send(action: .viewOnAppear)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    // IOS 15
    var iOS15View: some View {
        NavigationView {
            VStack {
                contentView
                NavigationLink(destination: UserInfoRegView(viewType: .first, ifNeedTrigger: {
                    navigationManager.send(action: .viewOnAppear)
                }), isActive: $isNextBool) {
                    EmptyView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    
}

extension splashView {
    private
    var contentView: some View {
        VStack(spacing: 10) {
            Image(Const.appLogo)
                .resizable()
                .modifier(cornerRadiusVersion(cornerRadius: 14))
                .modifier(SplashImageModifier())
                .padding(.vertical, 40)
        
            Text(Const.AppText.appName)
                .font(JHFont.appNameFont)
            
            
            Text(Const.AppText.appIntroduce)
                .font(JHFont.appIntroduceFont)
            
            Spacer()
            
            StartButtonView
        } // Vstack
    }
}

extension splashView {
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
            .foregroundStyle(JHColor.onlyWhite)
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(JHColor.likeColor)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
