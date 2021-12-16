//
//  TabBarViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct TabBarViewSUI: View {
    var body: some View {
        TabView {
            HomeViewSUI()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            SearchViewSUI()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }
            LibraryViewSUI()
                .tabItem{
                    Label("Library", systemImage: "music.note")
                }
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct TabBarViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        TabBarViewSUI()
    }
}
