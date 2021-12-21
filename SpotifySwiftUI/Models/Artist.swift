//
//  Artist.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 02/10/21.
//

import Foundation

struct Artists: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
