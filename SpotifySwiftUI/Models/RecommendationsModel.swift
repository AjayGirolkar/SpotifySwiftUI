//
//  RecommendationsResponseModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation


struct RecommendationsModel: Codable {
    let tracks: [AudioTrack]
    let seeds: [Seeds]
}

struct AudioTrack: Codable, Identifiable {
    let album: Album?
    let artists: [Artists]
    let availableMarkets: [String]?
    let discNumber: Int?
    let durationMS: Int?
    let explicit: Bool?
    let id: String?
    let name: String?
    let popularity : Int?
    
    private enum CodingKeys : String, CodingKey {
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case id
        case name
        case popularity
        
    }
}

struct Seeds: Codable, Identifiable {
    let initialPoolSize: Int
    let afterFilteringSize: Int
    let afterRelinkingSize: Int
    let id: String
    let type: String
}
