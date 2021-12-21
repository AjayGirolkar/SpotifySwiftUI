//
//  FeaturedPlayListInfoView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct FeaturedPlayListInfoView: View {
    let playlistItem: Playlist
    
    var body: some View {
        NavigationLink(destination:  CustomText(text:"\(playlistItem.name)")){
            HStack {
                SDWebImageManager.getImageFromUrl(url: playlistItem.images.first?.url ?? "")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: 100, height: 100, alignment: .topLeading)
                VStack(alignment: .leading) {
                     CustomText(text:"\(playlistItem.name)")
                        .foregroundColor(.primary)
                        .frame(alignment: .leading)
                }.padding()
                Spacer()
            }
            .frame(alignment: .leading)
        }
    }
}

struct FeaturedPlayListInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            if let item = DefautlValues.featuredPlaylistResponse.playlists.items.first {
                FeaturedPlayListInfoView(playlistItem: item)
            }
        }
    }
}
