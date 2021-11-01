//
//  AuthViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI
import Combine

struct AuthViewSUI: View {
    @ObservedObject var webViewModel = ViewModel()
    @StateObject var authObservable: AuthObservable = AuthObservable()
    @State var showAlert: Bool = false
    
    var body: some View {
        if let url = AuthManager.shared.signedInURL {
            VStack {
                if #available(iOS 15.0, *) {
                    WebViewSUI(url: url, viewModel: webViewModel, authObservable: authObservable)
                        .navigationBarTitle("Spotify")
                        .alert("Something went wrong when signing", isPresented: $showAlert) {
                        }
                } else {
                    // Fallback on earlier versions
                }
            }.onReceive(webViewModel.completionHandler, perform: { isSuccessed in
                showAlert = isSuccessed
            })
            
        }
    }
}

struct AuthViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewSUI()
    }
}
