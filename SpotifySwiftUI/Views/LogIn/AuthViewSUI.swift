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

    var body: some View {
        if let url = AuthManager.shared.signedInURL {
            WebViewSUI(url: url, viewModel: webViewModel, authObservable: authObservable)
                .navigationBarTitle("Spotify")
//                .environmentObject(globalVariables)
        }
    }
}

struct AuthViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewSUI()
    }
}
