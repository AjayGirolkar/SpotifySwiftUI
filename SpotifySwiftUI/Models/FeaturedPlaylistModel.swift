//
//  FeaturedPlaylistModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation


struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}
struct PlaylistResponse: Codable {
    let href: String
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]?
    let id: String
}
