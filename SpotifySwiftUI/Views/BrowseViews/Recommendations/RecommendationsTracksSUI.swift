//
//  RecommendationsTracksSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import SwiftUI

struct RecommendationsTracksSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    @Binding var recommendationsModel: RecommendationsModel
    @State var observableRecommendationsTracks = ObservableRecommendationsTracks()
    @State var colums =  Array(repeating: GridItem(.flexible()), count: 3)
    @Binding var recommendationsTracksSUI: CGFloat
    let itemWidth = UIScreen.main.bounds.width * 0.5

    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                VStack {
                    if !showErrorView {
                        addGridView()
                    }
                }.onAppear {
                    fetchRecommendationsData()
                }.onReceive(observableRecommendationsTracks.$recommendationsModel) { recommendationsModel in
                    self.recommendationsModel = recommendationsModel
                    decideColumnNumber()
                }
            }
        }
    }
    
    func decideColumnNumber() {
        let totalItems = recommendationsModel.tracks.count
        if totalItems == 0 {
            return
        }
        if totalItems < 10 {
            colums = [GridItem(.flexible())]
            recommendationsTracksSUI = 200
        } else if totalItems < 20 {
            colums = [GridItem(.flexible()), GridItem(.flexible())]
            recommendationsTracksSUI = 500
        } //by default 3
    }
    
    func addGridView() -> some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHGrid(rows: colums) {
                    ForEach(recommendationsModel.tracks.compactMap({$0})) { track in
                        NavigationLink(destination:  CustomText(text:"\(track.album.name)")){
                            VStack {
                                SDWebImageManager.getImageFromUrl(url: track.album.images.first?.url ?? "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .topLeading)
                                 CustomText(text:"\(track.album.name)")
                                    .foregroundColor(.primary)
                                 CustomText(text:"\(track.artists.first?.name ?? "-")")
                                    .foregroundColor(.primary)
                            }
                            .frame(width: itemWidth, height: recommendationsTracksSUI, alignment: .center)
                        }
                    }
                }.padding()
            })
        }
    }
    
    func fetchRecommendationsData() {
        isLoading = true
        APICaller.shared.getRecommendationsGenres { result in
            switch result {
            case .success(let recommendations):
                print(recommendations)
                let genres = recommendations.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds) { result in
                    switch result {
                    case .success(let recommendationsModel):
                        DispatchQueue.main.async {
                            observableRecommendationsTracks.recommendationsModel = recommendationsModel
                            isLoading = false
                        }
                    case .failure(let error):
                        print(ErrorMessage.getRecommendationsError + " \(error)")
                        isLoading = false
                        showErrorView = true
                    }
                } //end getRecommendations call
                case .failure(let error):
                print(ErrorMessage.getRecommendationsGenresError + "\(error)")
                    isLoading = false
                    showErrorView = true
                }
            }
        }}
    
    struct RecommendationsTracksSUI_Previews: PreviewProvider {
        static var previews: some View {
            RecommendationsTracksSUI(recommendationsModel: .constant(DefautlValues.recommendationsModel), recommendationsTracksSUI: .constant(300))
        }
    }
