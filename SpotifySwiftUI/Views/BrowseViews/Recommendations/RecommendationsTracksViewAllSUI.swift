//
//  RecommendationsTracksViewAllSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct RecommendationsTracksViewAllSUI: View {
    let recommendationsModel: RecommendationsModel
    let itemWidth = UIScreen.main.bounds.width

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                ForEach(recommendationsModel.tracks.compactMap({$0})) { track in
                    NavigationLink(destination:  CustomText(text:"\(track.album?.name)")){
                        RecommendationsTracksInfoView(track: track)
                        .frame(width: itemWidth, alignment: .center)
                        .padding()
                    }
                }
            }
        }.navigationTitle(SectionNames.featuredPlaylist)
    }
}

struct RecommendationsTracksViewAllSUI_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsTracksViewAllSUI(recommendationsModel: DefautlValues.recommendationsModel)
    }
}
