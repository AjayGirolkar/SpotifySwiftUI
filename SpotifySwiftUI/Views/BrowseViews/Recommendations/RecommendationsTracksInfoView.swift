//
//  RecommendationsTracksInfoView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct RecommendationsTracksInfoView: View {
    let track: AudioTrack
    
    var body: some View {
        HStack {
            SDWebImageManager.getImageFromUrl(url: track.album.images.first?.url ?? "")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: 100, height: 100, alignment: .topLeading)
            VStack(alignment: .leading, spacing: 20) {
                 CustomText(text: track.album.name)
                CustomText(text: track.artists.first?.name ?? "-")
            }.padding()
            Spacer()
        }
    }
}

struct RecommendationsTracksInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsTracksInfoView(track: DefautlValues.tracks)
    }
}
