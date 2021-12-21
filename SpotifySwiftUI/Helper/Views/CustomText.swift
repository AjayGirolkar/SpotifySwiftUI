//
//  CustomText.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

enum TextStyle {
    case defaultStyle
}

struct CustomText: View {
    let text: String
    let style: TextStyle = .defaultStyle
    
    var body: some View {
         Text(text)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "Custom text")
    }
}
