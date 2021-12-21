//
//  ProfileViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileViewSUI: View {
    
    
    @State var userProfile = UserProfile(country: "", displayName: "", email: "", explicitContent: nil, externalUrls: nil, followers: nil, href: nil, id: nil, images: nil, product: nil, type: nil, uri: nil)
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                VStack(alignment: .center, spacing: 20){
                    if showErrorView {
                         CustomText(text:"Error.. Failed to load Data")
                    } else {
                        VStack(alignment: .center) {
                            if let profileUrl = userProfile.images?.first?.url {
                                showProfileImage(Url: profileUrl)
                                    .frame(width: 100, height: 100, alignment: .center)
                                
                            } else {
                                Image("profile")
                                    .resizable().frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(50)
                            }
                        }
                        Spacer()
                            .frame(height: 50)
                        VStack(alignment: .leading,spacing:30) {
                            HStack(spacing:30){
                                 CustomText(text:"Username:")
                                 CustomText(text:userProfile.displayName)
                            }
                            HStack {
                                 CustomText(text:"Email:")
                                 CustomText(text:userProfile.email)
                            }
                            HStack {
                                 CustomText(text:"user Id:")
                                 CustomText(text:userProfile.id ?? "")
                            }
                            HStack {
                                 CustomText(text:"Plan:")
                                 CustomText(text:userProfile.product ?? "")
                            }
                            Spacer()
                        }.onAppear {
                            fetchData()
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .padding()
            }
        }.navigationTitle("Profile")
    }
    
    func showProfileImage(Url: String) -> some View {
        VStack {
            if let url =  URL(string: Url) {
                WebImage(url: url)
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
