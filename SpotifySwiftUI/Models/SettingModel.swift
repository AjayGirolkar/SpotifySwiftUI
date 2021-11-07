//
//  SettingModel.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 07/11/21.
//

import Foundation

struct SectionItem: Identifiable {    
    let id = UUID()
    let title: String
    let options: [Option]
}

struct Option: Identifiable {
    let id = UUID()
    let title: String
    let handler: (() -> Void)?
}
