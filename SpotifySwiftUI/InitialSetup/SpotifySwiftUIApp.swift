//
//  SpotifySwiftUIApp.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

@main
struct SpotifySwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            if AuthManager.shared.isSignedIn {
            TabBarViewSUI()
                .background(Color.blue)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                WelcomeViewSUI()
            }
        }
    }
}
