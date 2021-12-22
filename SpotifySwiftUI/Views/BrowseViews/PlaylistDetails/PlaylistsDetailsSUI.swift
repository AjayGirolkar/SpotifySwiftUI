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
    @ObservedObject var observablePlaylistDetailsModel = ObservablePlaylistDetailsModel()
    
    let itemWidth = UIScreen.main.bounds.width
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                List {
                    if !showErrorView {
                        VStack {
                            
                        }.background(Color.gray)
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                        if let items = observablePlaylistDetailsModel.playlistsDetailsResponse.tracks?.items {
                            ForEach(0..<items.count) { index in
                                let playlistItem = items[index]
                                addPlayListItemsInList(playlistItem: playlistItem)
                            }
                        }
                    }
                }.onAppear {
                    fetchPlaylistDetails()
                }.navigationTitle(SectionNames.featuredPlaylist)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func addPlayListItemsInList(playlistItem: PlaylistItem) -> some View {
            ImageTitleDescriptionView(url: playlistItem.track.album?.images.first?.url,
                                      title: playlistItem.track.name ?? "-",
                                      description: playlistItem.track.artists.first?.name ?? "-",
                                      lables: getLabelsForPlaylist(playlistItem: playlistItem))
                .background(NavigationLink("", destination: CustomText(text:"\(playlistItem.track.name ?? "")")).opacity(0))

    }
    
    func getLabelsForPlaylist(playlistItem: PlaylistItem) -> [String]? {
        var labels =  [String]()
        if let durationInMs = playlistItem.track.durationMS {
            let durationInMin = (durationInMs / 3600)
            let durationtext = "Duration: \(durationInMin) mins"
            labels = [durationtext]
        }
        return labels
    }
    
    func fetchPlaylistDetails() {
        APICaller.shared.getPlaylistDetails(for: playlist) { result in
                switch result {
                case .success(let playlistsDetailsResponse):
                    observablePlaylistDetailsModel.playlistsDetailsResponse = playlistsDetailsResponse
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
