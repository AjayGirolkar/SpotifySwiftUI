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
    var style: TextStyle = .defaultStyle
    var font: Font = .body
    var fontWight : Font.Weight = .regular
    
    var body: some View {
         Text(text)
            .fontWeight(fontWight)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "Custom text")
    }
}
