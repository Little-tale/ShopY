//
//  WKWebViewRepresent.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/27/24.
//

import SwiftUI
import WebKit

struct WKWebRepresentView: UIViewRepresentable {
    
    var url: URL?
    
    init(url: String) {
        guard let url = URL(string: url) else {
            self.url = nil
            return
        }
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url else { return WKWebView() }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ wkView: WKWebView, context: UIViewRepresentableContext<WKWebRepresentView>) {
        guard let url else { return }
        
        wkView.load(URLRequest(url: url))
    }
    
}
