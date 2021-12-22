//
//  PlaylistHeaderView.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 22/12/21.
//

import SwiftUI

struct PlayListHeaderViewModel {
    var imageUrl: String?
    var headingText: String
    var descriptionText: String?
    var display_name: String?
    var moreText: [String]?
    var external_urls: [String: String]?
    var playButtonCallBack: () -> Void
}

struct PlaylistHeaderView: View {
    //var playlistsDetailsResponse = DefautlValues.playlistsDetailsResponse
    let playListHeaderViewModel: PlayListHeaderViewModel
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    if let imageUrl = playListHeaderViewModel.imageUrl, !imageUrl.isEmpty {
                        SDWebImageManager.getImageFromUrl(
                            url: imageUrl,
                            size: CGSize(width: UIScreen.main.bounds.width * 0.4,
                                         height: UIScreen.main.bounds.width * 0.4))
                    }
                }
                Spacer().frame(height: 50)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        CustomText(text: playListHeaderViewModel.headingText, font: .headline, fontWight: .bold)
                        CustomText(text: playListHeaderViewModel.descriptionText ?? "", font: .body, fontWight: .regular)
                    }
                    Spacer()
                }
                HStack {
                    VStack {
                        CustomText(text: playListHeaderViewModel.display_name ?? "", font: .caption, fontWight: .regular)
                        ForEach(playListHeaderViewModel.moreText ?? [], id:\.self) { text in
                            CustomText(text: text)
                        }
                    }
                    Spacer()
                    addPlayButton()
                }
            }.frame(width: geometry.size.width)
        }
    }
    
    func addPlayButton() -> some View {
        Image(systemName: "play.circle.fill")
            .resizable()
            .cornerRadius(25)
            .frame(width: 50, height: 50, alignment: .center)
            .foregroundColor(.green)
            .background(Color.clear)
            .imageScale(.large)
            .onTapGesture {
                print("Play clicked")
                playListHeaderViewModel.playButtonCallBack()
                isSheetPresented = true
            }
    }
}

struct PlaylistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistHeaderView(playListHeaderViewModel: PlayListHeaderViewModel(imageUrl: "", headingText: "", descriptionText: "", display_name: "", moreText: nil, external_urls: nil, playButtonCallBack: {}))
    }
}
