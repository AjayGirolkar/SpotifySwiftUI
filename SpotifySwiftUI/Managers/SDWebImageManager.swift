//
//  SDWebImageManager.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 20/12/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

final class SDWebImageManager {
    
    static func getImageFromUrl(url: String?) -> WebImage {
        WebImage(url: URL(string: url ?? ""))
    }
}
