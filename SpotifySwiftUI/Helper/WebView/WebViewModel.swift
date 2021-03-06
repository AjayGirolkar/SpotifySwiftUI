//
//  WebViewModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 06/10/21.
//

import SwiftUI

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
}
