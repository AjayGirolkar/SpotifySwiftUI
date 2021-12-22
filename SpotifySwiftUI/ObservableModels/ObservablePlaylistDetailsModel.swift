//
//  ObservablePlaylistDetailsModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import Foundation
import Combine

class ObservablePlaylistDetailsModel: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var playlistsDetailsResponse = DefautlValues.playlistsDetailsResponse
}
