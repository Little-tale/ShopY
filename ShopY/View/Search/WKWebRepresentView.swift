//
//  WKWebViewRepresent.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import SwiftUI
import WebKit

struct WKWebRepresentView: UIViewRepresentable {
    
    var url: String
   
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            print("init URL ISSUE: FOR MAKE UIView")
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ wkView: WKWebView, context: UIViewRepresentableContext<WKWebRepresentView>) {
        guard let url = URL(string: url) else {
            print("init URL ISSUE: FOR MAKE updateUIView")
            return
        }
        
        wkView.load(URLRequest(url: url))
    }
    
}


struct WKConvertorView: View {
    
    let url: String
    
    var body: some View {
        VStack {
            WKWebRepresentView(url: url)
        }
        .onAppear {
            
        }
    }
    init(url: String) {
        self.url = url
        
        print("init : WKConvertorView \(url)")
    }
}
