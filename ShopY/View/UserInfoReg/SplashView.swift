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
    
    @State
    var changeRoot = false
    
    var body: some View {
        if changeRoot{
            TabbarView()
        } else {
            if #available(iOS 16, *){
                iOS16View
            } else {
                iOS15View
            }
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
                UserInfoRegView(viewType: .first, goTabBarView: $changeRoot)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    // IOS 15
    var iOS15View: some View {
        NavigationView {
            VStack {
                contentView
                NavigationLink(destination: UserInfoRegView(viewType: .first, goTabBarView: $changeRoot), isActive: $isNextBool) {
                    EmptyView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // 네비게이션
    private func navigationStyle() {
        let appear = UINavigationBarAppearance()
    
        appear.configureWithOpaqueBackground()
        appear.backgroundColor = UIColor(JHColor.white)
        appear.titleTextAttributes = [.foregroundColor: UIColor(JHColor.black)]
        appear.largeTitleTextAttributes = [.foregroundColor: UIColor(JHColor.white)]
        
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
    }
    // 네비게이션 버튼
    private func navigationButtonStyle(){
        let barButtonAppear = UIBarButtonItem.appearance()
        
        barButtonAppear.tintColor = UIColor(JHColor.black)
        
    }
}

extension splashView {
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
