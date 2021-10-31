//
//  AuthResponse.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/10/21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String?
    let expires_in: Int?
    let refresh_token: String?
    let token_type: String?
}
