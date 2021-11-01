//
//  APICaller.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 01/11/21.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
    }
}
