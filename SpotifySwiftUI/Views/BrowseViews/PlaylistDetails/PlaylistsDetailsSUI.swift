//
//  PlaylistsDetailsSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 21/12/21.
//

import SwiftUI

struct PlaylistsDetailsSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = true
    let playlist: Playlist
    @ObservedObject var observablePlaylistDetailsModel = ObservablePlaylistDetailsModel()
    
    let itemWidth = UIScreen.main.bounds.width
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                List {
                    if !showErrorView {
                        if let items = observablePlaylistDetailsModel.playlistsDetailsResponse.tracks?.items,
                           items.count > 0 {
                            if let playlistsDetailsResponse = observablePlaylistDetailsModel.playlistsDetailsResponse {
                                let playListHeaderViewModel = PlayListHeaderViewModel(imageUrl: playlistsDetailsResponse.images?.first?.url, headingText: playlistsDetailsResponse.name, descriptionText: playlistsDetailsResponse.description, display_name: playlistsDetailsResponse.owner?.display_name, moreText: nil, external_urls: playlistsDetailsResponse.external_urls, playButtonCallBack: {
                                    
                                })
                            PlaylistHeaderView(playListHeaderViewModel: playListHeaderViewModel)
                                .frame(height: geometry.size.height * 0.5)
                            ForEach(0..<items.count) { index in
                                let playlistItem = items[index]
                                addPlayListItemsInList(playlistItem: playlistItem)
                            }
                            }
                        }
                    } else {
                        Text(StringConstants.loadDataErrorMessage)
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
                showErrorView = false
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
