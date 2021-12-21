//
//  DefaultValues.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import Foundation


struct DefautlValues {
    static let newReleaseResponseModel: NewReleaseResponseModel = NewReleaseResponseModel(albums: AlbumResponse(href: "", items: [], limit: 0))
    static let featuredPlaylistResponse = FeaturedPlaylistResponse(playlists: PlaylistResponse(href: "", items: []))
    static let recommendationsModel = RecommendationsModel(tracks: [], seeds: [])
    static let album = Album(album_type: "", artists: [], available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, type: "", external_urls:nil)
    static let tracks = AudioTrack(album: album, artists: [], availableMarkets: [], discNumber: 0, durationMS: 0, explicit: false, id: "", name: "", popularity: 0)
    
    static let user = User(display_name: "", external_urls: [:], id: "")
    static let playlist = Playlist(description: "", external_urls: [:], id: "", images: [], name: "", owner: user)
}
