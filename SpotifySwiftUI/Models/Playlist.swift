//
//  Playlist.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 02/10/21.
//

import Foundation

struct Playlist: Codable, Identifiable {
    let description: String
    let external_urls: [String: String]?
    let id: String
    let images: [APIImageModel]
    let name: String
    let owner: User
}
