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
        HStack {
            SDWebImageManager.getImageFromUrl(url: url ?? "",
                                              size: CGSize(width: 100, height: 100))
            VStack(alignment: .leading, spacing: 20) {
                CustomText(text: title)
                CustomText(text: description)
                if let lables = lables {
                    ForEach(lables, id: \.self){ text in
                        CustomText(text: text)
                    }
                }
            }.padding()
            Spacer()
        }
    }
}

struct ImageTitleDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
    ImageTitleDescriptionView(url: "", title: "", description: "")
    }
}
