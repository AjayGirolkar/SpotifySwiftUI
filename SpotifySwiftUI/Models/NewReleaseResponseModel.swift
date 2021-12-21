//
//  NewReleaseResponseModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation

struct NewReleaseResponseModel: Codable {
    let albums: AlbumResponse
}

struct AlbumResponse: Codable {
    let href: String?
    let items: [Album]
    let limit: Int
}

struct Album: Codable, Identifiable {
    let album_type: String
    let artists: [Artists]
    let available_markets: [String]
    let id: String
    let images: [APIImageModel]
    let name: String
    let release_date: String
    let total_tracks: Int
    let type: String
    let external_urls: [String: String]?
}

