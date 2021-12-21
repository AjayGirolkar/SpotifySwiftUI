//
//  BrowsAPIs.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import Foundation

extension APICaller {
    
    func getDataForUrl<Model>(_ model: Model.Type, url: URL?, httpMethodType: HTTPMethod, localFileName: MockFileName, completion: @escaping ((Result<Model, Error>)) -> Void) where Model : Codable
    {
        createRequest(with: url, type: httpMethodType) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                var jsonData: Data?
                
                if let data = data {
                    jsonData = data
                } else { //Mock Response
                    print("Getting Mock response")
                    jsonData = MockAPIManager.readLocalFile(forName: localFileName)
                }
                guard let jsonData = jsonData else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let genericModel = try JSONDecoder().decode(Model.self, from: jsonData)
                    completion(.success(genericModel))
                }
                catch {
                    completion(.failure(error))
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                }
            }
            task.resume()
        }
    }
    
    func checkLocalDataParsing<Model>(_ model: Model.Type, localFileName: MockFileName, completion: (Model) -> Void) where Model : Codable {
        if let jsonData = MockAPIManager.readLocalFile(forName: localFileName) {
            do {
                let genericModel = try JSONDecoder().decode(Model.self, from: jsonData)
                print(genericModel)
                completion(genericModel)
            } catch {
                print(error)
            }}
    }
    
    
    public func getNewReleases(completion: @escaping ((Result<NewReleaseResponseModel, Error>)) -> Void) {
        getDataForUrl(NewReleaseResponseModel.self, url: URL(string: Constants.baseAPIURL + Constants.newReleasesEndPoint), httpMethodType: .GET, localFileName: .NewReleaseResponse) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getFeaturedPlayLists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>) -> Void)) {
        getDataForUrl(FeaturedPlaylistResponse.self, url: URL(string: Constants.baseAPIURL + Constants.featuredPlaylistEndPoint), httpMethodType: .GET, localFileName: .FeaturedPlaylist) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsModel, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        getDataForUrl(RecommendationsModel.self, url: URL(string: Constants.baseAPIURL + Constants.recomendationsEndPoint + seeds), httpMethodType: .GET, localFileName: .FeaturedPlaylist) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getRecommendationsGenres(completion: @escaping ((Result<RecommendationsGenresModel, Error>) -> Void)) {
        getDataForUrl(RecommendationsGenresModel.self, url: URL(string: Constants.baseAPIURL + Constants.recomendationsGenresEndPoint), httpMethodType: .GET, localFileName: .RecommendationsGenresResponse) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAlbumDetails(for album: Album, completion: @escaping ((Result<AlbumDetailsResponse, Error>) -> Void)) {
        getDataForUrl(AlbumDetailsResponse.self, url: URL(string: Constants.baseAPIURL + Constants.albumsEndPoint + album.id), httpMethodType: .GET, localFileName: .AlbumDetails) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPlaylistDetails(for playlist: Playlist, completion: @escaping ((Result<PlaylistsDetailsResponse, Error>) -> Void)) {
        checkLocalDataParsing(PlaylistsDetailsResponse.self, localFileName: .PlaylistsDetailsResponse) { model in
            print(model)
        }
        getDataForUrl(PlaylistsDetailsResponse.self, url: URL(string: Constants.baseAPIURL + Constants.playlistsEndPoint + playlist.id), httpMethodType: .GET, localFileName: .PlaylistsDetailsResponse) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
