//
//  PlaylistsDetailsResponse.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import Foundation


struct PlaylistsDetailsResponse: Codable, Identifiable {
    let collaborative: Bool?
    let description: String
   //let external_urls: [String: String]?
    let followers: Followers?
    let href: String?
    let id: String
    let images: [APIImage]?
    let name: String
    let primary_color: String?
    let snapshot_id: String?
    let tracks: PlaylistsTracksResponse?
    let type: String?
    let uri: String?
}

struct PlaylistsTracksResponse: Codable {
    let href: String?
    let items: [PlaylistItem]?
}

struct PlaylistItem: Codable {
    let track: AudioTrack
    let primary_color: String?
    let video_thumbnail: [String: String?]
}

struct Followers: Codable {
    let href: String?
    let total: Int?
}
