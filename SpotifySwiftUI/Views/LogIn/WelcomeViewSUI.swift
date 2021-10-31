//
//  WelcomeViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct WelcomeViewSUI: View {
    @StateObject var authObservable: AuthObservable = AuthObservable()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: AuthViewSUI(authObservable: authObservable)) {
                    Text("Sign In")
                        .foregroundColor(.blue)
                }.background(Color.white)
                    .frame(width: UIScreen.main.bounds.width)
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width,
                   alignment: .center)
            .background(Color.green)
            .padding()
            .navigationBarTitle("Spotify")
        }
    }
}

struct WelcomeViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeViewSUI()
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
