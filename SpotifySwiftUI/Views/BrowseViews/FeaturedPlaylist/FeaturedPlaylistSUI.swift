//
//  FeaturedPlaylistSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import SwiftUI

struct FeaturedPlaylistSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    @Binding var featuredPlaylistResponse: FeaturedPlaylistResponse
    @State var observableFeaturedPlaylistModel = ObservableFeaturedPlaylistModel()
    @State var colums =  Array(repeating: GridItem(.flexible()), count: 3)
    let itemWidth = UIScreen.main.bounds.width * 0.5
    @Binding var newReleasesSUIHeight: CGFloat

    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                VStack {
                    if !showErrorView {
                        addGridView()
                    }
                }.onAppear {
                    fetchFeaturedPlayListsData()
                }.onReceive(observableFeaturedPlaylistModel.$featuredPlaylistResponse) { featuredPlaylistResponse in
                    self.featuredPlaylistResponse = featuredPlaylistResponse
                    decideColumnNumber()
                }
            }
        }
    }
    
    func decideColumnNumber() {
        let totalItems = featuredPlaylistResponse.playlists.items.count
        if totalItems == 0 {
            return
        }
        if totalItems < 10 {
            colums = [GridItem(.flexible())]
            newReleasesSUIHeight = 150
        } else if totalItems < 20 {
            colums = [GridItem(.flexible()), GridItem(.flexible())]
            newReleasesSUIHeight = 300
        } //by default 3
    }
    
    func addGridView() -> some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false, content: {
                
                LazyHGrid(rows: colums) {
                    ForEach(featuredPlaylistResponse.playlists.items) { playlistItem in
                        NavigationLink(destination: PlaylistsDetailsSUI(playlist: playlistItem)){
                            VStack {
                                SDWebImageManager.getImageFromUrl(url: playlistItem.images.first?.url ?? "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .topLeading)
                                 CustomText(text:"\(playlistItem.name)")
                                    .foregroundColor(.primary)
                            }
                            .frame(width: itemWidth, height: newReleasesSUIHeight, alignment: .leading)
                        }
                    }
                }.padding()
            })
        }
    }
    
    func fetchFeaturedPlayListsData() {
        APICaller.shared.getFeaturedPlayLists { result in
            switch result {
            case .success(let featuredPlaylistResponse):
                DispatchQueue.main.async {
                    observableFeaturedPlaylistModel.featuredPlaylistResponse = featuredPlaylistResponse
                    isLoading = false
                }
            case .failure(let error):
                print(ErrorMessage.getFeaturedPlayListsEror + "\(error)")
                isLoading = false
                showErrorView = true
            }
        }
    }
}

struct FeaturedPlaylistSUI_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPlaylistSUI( featuredPlaylistResponse: .constant(DefautlValues.featuredPlaylistResponse), newReleasesSUIHeight: .constant(300))
    }
}
