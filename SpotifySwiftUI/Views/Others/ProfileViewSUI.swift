//
//  ProfileViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct ProfileViewSUI: View {
    
    
    @State var userProfile = UserProfile(country: "", displayName: "", email: "", explicitContent: nil, externalUrls: nil, href: nil, id: nil, images: nil, product: nil, type: nil, uri: nil)
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Username")
                Text(userProfile.displayName)
            }
            HStack {
                Text("Email")
                Text(userProfile.email)
            }
        } .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case .success(let user):
                self.userProfile = user
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ProfileViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewSUI()
    }
}
