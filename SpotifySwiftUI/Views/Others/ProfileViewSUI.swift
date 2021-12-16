//
//  ProfileViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct ProfileViewSUI: View {
    
    
    @State var userProfile = UserProfile(country: "", displayName: "", email: "", explicitContent: nil, externalUrls: nil, href: nil, id: nil, images: nil, product: nil, type: nil, uri: nil)
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                VStack{
                    if showErrorView {
                        Text("Error.. Failed to load Data")
                    } else {
                        VStack {
                            HStack {
                                Text("Username")
                                Text(userProfile.displayName)
                            }
                            HStack {
                                Text("Email")
                                Text(userProfile.email)
                            }
                        }.onAppear {
                            fetchData()
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
    }
    
    func fetchData() {
        isLoading = true
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case .success(let user):
                self.userProfile = user
                print(user)
                isLoading = false
            case .failure(let error):
                print(error)
                isLoading = false
                showErrorView = true
            }
        }
    }
}

struct ProfileViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewSUI()
    }
}
