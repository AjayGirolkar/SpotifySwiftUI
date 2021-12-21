//
//  NewReleasesViewAllSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct NewReleasesViewAllSUI: View {
    var newReleaseResponseModel: NewReleaseResponseModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                ForEach(newReleaseResponseModel.albums.items) { albumItem in
                    NavigationLink(destination:  CustomText(text:"\(albumItem.name)")){
                        NewReleaseAlbumInfoView(album: albumItem)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    }
                    .buttonStyle(PlainButtonStyle()) //to hide blue color of text
                }
            }
        }.navigationTitle(SectionNames.recomendations)
    }
}

struct NewReleasesViewAllSUI_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesViewAllSUI(newReleaseResponseModel: DefautlValues.newReleaseResponseModel)
    }
}
