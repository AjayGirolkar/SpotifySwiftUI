//
//  NewReleaseAlbumInfoView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 20/12/21.
//

import SwiftUI

struct NewReleaseAlbumInfoView: View {
    let album: Album?
    
    var body: some View {
        if let album = album {
            HStack(alignment: .top, spacing: 10) {
                SDWebImageManager.getImageFromUrl(url: album.images.first?.url ?? "",
                                                  size: CGSize(width: 100, height: 100))
                VStack(alignment: .leading, spacing: 5) {
                     CustomText(text:album.name)
                     CustomText(text:album.artists.first?.name ?? "")
                        .font(.body)
                     CustomText(text:"total: \(album.total_tracks)")
                        .font(.caption2)
                }
            }.padding()
        }
    }
}

struct NewReleaseAlbumInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleaseAlbumInfoView(album: nil)
    }
}
