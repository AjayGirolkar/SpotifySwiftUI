//
//  HomeViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct HomeViewSUI: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .toolbar {
                    NavigationLink(destination: SettingViewSUI()) {
                        Image.init(systemName: "gear")
                    }
                }
        }
    }
}

struct HomeViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSUI()
    }
}
