//
//  AuthManager.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 03/10/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    struct Constants {
        static let clientID = "87dfd0e54adf45b78cc78e43b62de17c"
        static let cliendSecreteID = "48e173dd73ac4ce390d1748b8f44bde0"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirect_uri = "https://www.iosacademy.io"
        static let scopes = "user-read-private%20playlist-modify-private%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    public var signedInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let url = baseURL + "?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(String(describing: Constants.redirect_uri))&show_dialoge=TRUE"
        return URL(string: url) ?? nil
    }
    var isUserLoggedIn : Bool = false
    private var refreshingToken: Bool = false
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let tokenExpirationDate = tokenExpirationDate else {
            return true
        }
        let currentDate = Date()
        let fiveMinuts: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinuts) >= tokenExpirationDate
    }
    
    public func exchangeCodeForToken(code: String,
                                     completion: @escaping (Bool) -> Void) {
        //Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: "https://www.iosacademy.io"),]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID + ":" + Constants.cliendSecreteID
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("failure to get base 64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil else {
                      completion(false)
                      return
                  }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
                completion(true)
                print(result)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
    }
    
    private var onRefreshBlock = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlock.append(completion)
            return
        }
        if shouldRefreshToken {
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = refreshToken else {
            return
        }
        //Refresh Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken),]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = Constants.clientID + ":" + Constants.cliendSecreteID
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("failure to get base 64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.refreshingToken =  false
            
            guard let data = data,
                  error == nil else {
                      completion(false)
                      return
                  }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.onRefreshBlock.forEach{$0(result.access_token)}
                self.cacheToken(result: result)
                print("Successfully refreshed token ")
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in )),
                                       forKey: "expirationDate")
        
    }
}

class AuthObservable: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
