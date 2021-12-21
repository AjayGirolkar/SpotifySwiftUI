//
//  PlaylistsDetailsSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct PlaylistsDetailsSUI: View {
        @State var isLoading: Bool = true
        @State var showErrorView: Bool = false
        let playlist: Playlist
        
        var body: some View {
            GeometryReader { geometry in
                LoadingView(isShowing: $isLoading) {
                    List {
                        if !showErrorView {
                            Text("Hello, World!")
                        }
                    }.onAppear {
                        fetchPlaylistDetails()
                    }
                }
            }
        }
        
        func fetchPlaylistDetails() {
            APICaller.shared.getPlaylistDetails(for: playlist) { result in
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

struct PlaylistsDetailsSUI_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsDetailsSUI(playlist: DefautlValues.playlist)
    }
}
