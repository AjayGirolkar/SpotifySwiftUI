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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var globalVariables = GlobalVariables()
    @StateObject var authObservable: AuthObservable = AuthObservable()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if authObservable.isLoggedIn {
                    TabBarViewSUI()
                        .background(Color.blue)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    WelcomeViewSUI(authObservable: authObservable)
                }
            }
//            .environmentObject(globalVariables)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(">> your code here !!")
        let dictionary = NSDictionary(object: "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36", forKey: "UserAgent" as NSCopying)
        UserDefaults.standard.register(defaults: dictionary as! [String : Any])
        return true
    }
}
