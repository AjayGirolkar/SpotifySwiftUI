//
//  BaseViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 03/10/21.
//

import SwiftUI

struct BaseViewSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    
    var body: some View {
         CustomText(text:/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BaseViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewSUI()
    }
}
