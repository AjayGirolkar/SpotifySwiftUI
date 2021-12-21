//
//  ObservableFeaturedPlaylistModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 20/12/21.
//

import Foundation
import Combine

class ObservableFeaturedPlaylistModel: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var featuredPlaylistResponse = FeaturedPlaylistResponse(playlists: PlaylistResponse(href: "", items: []))
}
