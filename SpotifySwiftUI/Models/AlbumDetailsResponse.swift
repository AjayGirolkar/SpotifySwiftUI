//
//  AlbumDetailsRessponse.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import Foundation


struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artists]
    let external_urls: [String: String]
    let genres: [String]?
    let href: String
    let images: [APIImage]
    let label: String
    let name: String
    let popularity: Int
    let release_date: String
    let total_tracks: Int
    let tracks: TracksResponse
    let uri: String
    let type: String
}


struct TracksResponse: Codable {
    let href: String
    let items: [AudioTrack]?
    let limit: Int
    let next: String?
    let previous: String?
    let total: Int?
}
