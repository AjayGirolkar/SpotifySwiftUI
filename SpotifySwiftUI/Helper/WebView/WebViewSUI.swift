//
//  WebViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 03/10/21.
//

import WebKit
import SwiftUI
import Combine

class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
    var popToViewController = PassthroughSubject<Bool, Never>()
    var completionHandler = PassthroughSubject<Bool, Never>()
}

enum WebViewNavigation {
    case backward, forward
}

enum WebUrl {
    case localUrl, publicUrl
}

struct WebViewSUI: UIViewRepresentable {
    
    var url: URL
    @ObservedObject var viewModel: ViewModel
    @StateObject var authObservable: AuthObservable = AuthObservable()

    var wkWebView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        let wkWebView = WKWebView(frame: .zero, configuration: config)
        return wkWebView
    }()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebViewSUI
        var webViewNavigationSubscriber: AnyCancellable? = nil

        init(_ uiWebView: WebViewSUI) {
            self.parent = uiWebView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Page loaded so no need to show loader anymore
            self.parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.viewModel.showLoader.send(false)
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let codeURL = navigationAction.request.url?.absoluteString ?? ""
            if codeURL.contains("code="),
               let code = codeURL.components(separatedBy: "code=").last, !code.isEmpty{
                print("code = \(code) \n\n")
                AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] isLoggedIn in
                    DispatchQueue.main.async {
                       self?.parent.authObservable.isLoggedIn = isLoggedIn
                        self?.parent.viewModel.completionHandler.send(isLoggedIn)
                        self?.parent.viewModel.popToViewController.send(isLoggedIn)
                    }
                }
            }
            decisionHandler(.allow)
        }
    }
}
