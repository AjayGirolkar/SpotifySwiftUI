//
//  MockAPIManager.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation

enum MockFileName: String {
    case NewReleaseResponse
    case FeaturedPlaylist
    case RecommendationsResponse
    case RecommendationsGenresResponse
    case AlbumDetails
    case PlaylistsDetailsResponse
}

class MockAPIManager {
    
    static func readLocalFile(forName name: MockFileName) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name.rawValue,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
