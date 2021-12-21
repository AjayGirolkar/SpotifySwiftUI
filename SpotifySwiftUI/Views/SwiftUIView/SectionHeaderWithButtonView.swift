//
//  SectionHeaderWithButtonView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct SectionHeaderWithButtonView<Content: View>: View {
    let header: String
    let buttonText: String = "View All"
    @ViewBuilder var content: Content

    var body: some View {
        HStack {
             CustomText(text:header)
            Spacer()
            NavigationLink(buttonText) {
                content
            }
        }
    }
}

struct SectionHeaderWithButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderWithButtonView(header: "") {
             CustomText(text:"")
        }
    }
}
