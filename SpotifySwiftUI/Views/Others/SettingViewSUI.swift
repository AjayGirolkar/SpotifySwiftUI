//
//  SettingViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI



struct SettingViewSUI: View {
    
    
    var sectionArray: [SectionItem]?
    
    init() {
        sectionArray = [SectionItem(title: "Profile", options: [Option(title: "View your profile", handler: nil)]),
                        SectionItem(title: "Account", options: [Option(title: "Sign out", handler: nil)])]
    }
    
    var body: some View {
        List {
            if let sectionArray = sectionArray {
                ForEach(sectionArray) { section in
                    if #available(iOS 15.0, *) {
                        switch section.title {
                        case "Profile" :
                            Section(section.title) {
                                ForEach(section.options) { option in
                                    NavigationLink(option.title, destination: ProfileViewSUI())
                                }
                            }
                        case "Account":
                            Section(section.title) {
                                ForEach(section.options) { option in
                                    NavigationLink(option.title, destination: ProfileViewSUI())
                                }
                            }
                        default:
                            VStack{}
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("Setting")
    }
}

struct SettingViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingViewSUI()
    }
}
