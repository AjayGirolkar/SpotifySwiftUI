//
//  BrowsAPIs.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation

extension APICaller {
    
    public func getNewReleases(completion: @escaping ((Result<NewReleaseResponseModel, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.newReleasesEndPoint), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                var jsonData: Data?
                
                if let data = data {
                    jsonData = data
                } else { //Mock Response
                    print("Getting Mock response")
                    jsonData = MockAPIManager.readLocalFile(forName: .NewReleaseResponse)
                }
                guard let jsonData = jsonData else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let newReleaseResponseModel = try JSONDecoder().decode(NewReleaseResponseModel.self, from: jsonData)
                   // print(newReleaseResponseModel)
                    completion(.success(newReleaseResponseModel))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    public func getFeaturedPlayLists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.featuredPlaylistEndPoint), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                var jsonData: Data?
                if let data = data {
                    jsonData = data
                } else { //Mock Response
                    print("Getting Mock response")
                    jsonData = MockAPIManager.readLocalFile(forName: .FeaturedPlaylist)
                }
                guard let jsonData = jsonData else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let featuredPlaylistResponse = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: jsonData)
                    print(featuredPlaylistResponse)
                    completion(.success(featuredPlaylistResponse))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsModel, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.recomendationsEndPoint + seeds),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                var jsonData: Data?
                if let data = data {
                    jsonData = data
                } else { //Mock Response
                    print("Getting Mock response")
                    jsonData = MockAPIManager.readLocalFile(forName: .RecommendationsResponse)
                }
                guard let jsonData = jsonData else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                    let result = try JSONDecoder().decode(RecommendationsModel.self, from: jsonData)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    
    func getRecommendationsGenres(completion: @escaping ((Result<RecommendationsGenresModel, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + Constants.recomendationsGenresEndPoint),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
                var jsonData: Data?
                if let data = data {
                    jsonData = data
                } else { //Mock Response
                    print("Getting Mock response")
                    jsonData = MockAPIManager.readLocalFile(forName: .RecommendationsGenresResponse)
                }
                guard let jsonData = jsonData else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                    let result = try JSONDecoder().decode(RecommendationsGenresModel.self, from: jsonData)
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
