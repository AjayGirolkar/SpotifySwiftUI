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
    
    static func getImageFromUrl(url: String?, size: CGSize) -> some View {
        WebImage(url: URL(string: url ?? ""))
            .resizable()
            .scaledToFit()
            .shadow(color: .gray, radius: 10, x: 0, y: 0)
            .cornerRadius(10)
            .frame(width: size.width, height: size.height, alignment: .center)
    }
}
