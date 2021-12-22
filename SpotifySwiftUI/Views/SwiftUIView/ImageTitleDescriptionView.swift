//
//  ImageTitleDescriptionView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct ImageTitleDescriptionView: View {
    let url: String?
    let title: String
    let description: String
    var lables: [String]? = nil
    
    var body: some View {
        HStack(spacing: 20) {
            if let url = url, !url.isEmpty {
                SDWebImageManager.getImageFromUrl(url: url,
                                                  size: CGSize(width: 60, height: 60))
            }
            VStack(alignment: .leading, spacing: 10) {
                CustomText(text: title, fontWight: .bold)
                CustomText(text: description)
                if let lables = lables {
                    ForEach(lables, id: \.self){ text in
                        CustomText(text: text)
                    }
                }
            }.padding([.top, .bottom])
            Spacer()
        }
    }
}

struct ImageTitleDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
    ImageTitleDescriptionView(url: "", title: "", description: "")
    }
}
