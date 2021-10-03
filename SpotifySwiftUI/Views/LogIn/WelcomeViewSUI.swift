//
//  WelcomeViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct WelcomeViewSUI: View {
    var body: some View {
        NavigationView {
            if let url = URL(string: "https://www.raywenderlich.com/5824937-swiftui-tutorial-navigation")
            {
                WebViewSUI(url: url)
                    .navigationBarTitle("Spotify")
            }
        }
        
    }
}

struct WelcomeViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeViewSUI()
    }
}
