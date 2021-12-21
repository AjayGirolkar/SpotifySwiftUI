//
//  FeaturedPlayListViewAllSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct FeaturedPlayListViewAllSUI: View {
    
    let featuredPlaylistResponse: FeaturedPlaylistResponse
    let itemWidth = UIScreen.main.bounds.width

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                ForEach(featuredPlaylistResponse.playlists.items) { playlistItem in
                    NavigationLink(destination:  CustomText(text:"\(playlistItem.name)")){
                        FeaturedPlayListInfoView(playlistItem: playlistItem)
                            .frame(width: itemWidth, alignment: .leading)
                        .padding()
                    }
                }
            }
        }.navigationTitle(SectionNames.featuredPlaylist)
    }
}

struct FeaturedPlayListViewAllSUI_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPlayListViewAllSUI(featuredPlaylistResponse: DefautlValues.featuredPlaylistResponse)
    }
}
