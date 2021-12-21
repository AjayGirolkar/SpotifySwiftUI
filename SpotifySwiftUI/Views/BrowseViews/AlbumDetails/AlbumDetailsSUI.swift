//
//  AlbumDetailsSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct AlbumDetailsSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    let album: Album
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                List {
                    if !showErrorView {
                        Text("Hello, World!")
                    }
                }.onAppear {
                    fetchAlbumDetails()
                }
            }
        }
    }
    
    func fetchAlbumDetails() {
        APICaller.shared.getAlbumDetails(for: album) { result in
            switch result {
            case .success(let albumDetailsModel):
                print(albumDetailsModel)
                isLoading = false
            case .failure(let error):
                print(ErrorMessage.fetchAlbumDetailsError + "\(error)")
                isLoading = false
                showErrorView = true
            }
        }
    }
    
}

struct AlbumDetailsSUI_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsSUI(album: DefautlValues.album)
    }
}
