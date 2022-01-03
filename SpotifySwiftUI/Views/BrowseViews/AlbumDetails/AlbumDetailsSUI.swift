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
    @ObservedObject var observableAlbumDetailsModel = ObservableAlbumDetailsModel()
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                List {
                    if !showErrorView {
                        if let albumResponse = observableAlbumDetailsModel.albumDetailsResponse {
                            if let items = albumResponse.tracks.items, items.count > 0 {
                                addPlaylistHeaderModel(albumResponse: albumResponse, geometry: geometry)
                                ForEach(0..<items.count) { index in
                                    let audioTrackItem = items[index]
                                    addPlayListItemsInList(audioTrack: audioTrackItem)
                                }
                            }
                        }
                    } else {
                        Text(StringConstants.loadDataErrorMessage)
                    }
                }.onAppear {
                    fetchAlbumDetails()
                }.navigationTitle(SectionNames.featuredPlaylist)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func addPlaylistHeaderModel(albumResponse: AlbumDetailsResponse, geometry: GeometryProxy) -> some View {
        VStack {
            let playListHeaderViewModel = PlayListHeaderViewModel(
                imageUrl: albumResponse.images.first?.url,
                headingText: albumResponse.name,
                descriptionText: "Release Date: \(String.formattedDate(string: albumResponse.release_date))",
                display_name: albumResponse.label, moreText: nil, external_urls: nil, playButtonCallBack: {})
            PlaylistHeaderView(playListHeaderViewModel: playListHeaderViewModel)
                .frame(height: geometry.size.height * 0.5)
        }
    }
    
    func addPlayListItemsInList(audioTrack: AudioTrack) -> some View {
        ImageTitleDescriptionView(url: "",
                                  title: audioTrack.name ?? "",
                                  description: "",
                                  lables: getLabelsForPlaylist(audioTrack: audioTrack))
            .background(NavigationLink("", destination: CustomText(text:"\(audioTrack.name ?? "")")).opacity(0))
        
    }
    
    func getLabelsForPlaylist(audioTrack: AudioTrack?) -> [String]? {
        var labels =  [String]()
        if let durationInMs = audioTrack?.durationMS {
            let durationInMin = (durationInMs / 3600)
            let durationtext = "Duration: \(durationInMin) mins"
            labels = [durationtext]
        }
        return labels
    }
    
    func fetchAlbumDetails() {
        APICaller.shared.getAlbumDetails(for: album) { result in
            switch result {
            case .success(let albumDetailsModel):
                print(albumDetailsModel)
                self.observableAlbumDetailsModel.albumDetailsResponse = albumDetailsModel
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

struct AlbumDetailsSUI_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsSUI(album: DefautlValues.album)
    }
}
