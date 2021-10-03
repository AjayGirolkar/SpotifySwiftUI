//
//  WebViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 03/10/21.
//

import WebKit
import SwiftUI

struct WebViewSUI: UIViewRepresentable {
    
    var url: URL
    
    var wkWebView: WKWebView {
        let wkWebView = WKWebView(frame: .zero)
        return wkWebView
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
}
