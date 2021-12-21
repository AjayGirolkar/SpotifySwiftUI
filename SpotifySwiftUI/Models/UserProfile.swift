//
//  UserProfile.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 02/10/21.
//

import Foundation

struct UserProfile: Codable {
    
    var country: String
    let displayName: String
    let email: String
    let explicitContent: [String: Bool]?
    let externalUrls: [String: String]?
    let followers: Follower?
    let href: String?
    let id: String?
    let images: [UserImage]?
    let product: String?
    let type: String?
    let uri: String?
    
    private enum CodingKeys : String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case images
        case product
        case type
        case uri
    }
}

struct Follower: Codable {
    let href: String?
    let total: Int?
}

struct UserImage: Codable {
    let url: String?
    let width: Int?
    let height: Int?
}
