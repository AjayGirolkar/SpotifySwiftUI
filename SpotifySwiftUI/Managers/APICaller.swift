//
//  APICaller.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 01/11/21.
//

import Foundation
import Combine

final class APICaller: ObservableObject {
    
    static let shared = APICaller()
    @Published var userProfile = UserProfile(country: "", displayName: "", email: "", explicitContent: nil, externalUrls: nil, followers: nil, href: nil, id: nil, images: nil, product: nil, type: nil, uri: nil)
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
        static let newReleasesEndPoint = "/browse/new-releases?limit=50"
        static let featuredPlaylistEndPoint = "/browse/featured-playlists?limit=2"
        static let recomendationsEndPoint  = "/recommendations?limit=40&seed_genres="
        static let recomendationsGenresEndPoint  = "/recommendations/available-genre-seeds"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.setValue("application/json",
                             forHTTPHeaderField: "Content-Type")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(String(data: data, encoding: .utf8) ?? "")
                    print(result)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
