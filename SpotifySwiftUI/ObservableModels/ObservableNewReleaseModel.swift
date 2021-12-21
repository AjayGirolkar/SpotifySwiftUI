//
//  ObservableNewReleaseModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 20/12/21.
//

import Foundation
import Combine

class ObservableNewReleaseModel: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var newReleaseModel = NewReleaseResponseModel(albums: AlbumResponse(href: "", items: [], limit: 0))
}
