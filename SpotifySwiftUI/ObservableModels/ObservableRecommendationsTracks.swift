//
//  ObservableRecommendationsTracks.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 20/12/21.
//

import Foundation
import Combine

class ObservableRecommendationsTracks: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var recommendationsModel = RecommendationsModel(tracks: [], seeds: [])
}
