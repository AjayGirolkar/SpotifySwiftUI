//
//  HomeViewSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 30/09/21.
//

import SwiftUI

struct HomeViewSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    
    @State var newReleasesSUIHeight: CGFloat = 450
    @State var featuredPlaylistSUISUIHeight: CGFloat = 450
    @State var recommendationsTracksSUI: CGFloat = 500
    @State var newReleaseResponseModel: NewReleaseResponseModel = DefautlValues.newReleaseResponseModel
    @State var featuredPlaylistResponse = DefautlValues.featuredPlaylistResponse
    @State var recommendationsModel = DefautlValues.recommendationsModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                LoadingView(isShowing: $isLoading) {
                    List {
                        if showErrorView {
                             CustomText(text:StringConstants.loadDataErrorMessage)
                        } else {
                            Section {
                                NewReleasesSUI(newReleaseResponseModel: $newReleaseResponseModel, newReleasesSUIHeight: $newReleasesSUIHeight)
                                    .frame(width: geometry.size.width, height: newReleasesSUIHeight, alignment: .center)
                                    .listRowInsets(EdgeInsets())
                            } header: {
                                SectionHeaderWithButtonView(header: SectionNames.newReleases, content: {
                                    NewReleasesViewAllSUI(newReleaseResponseModel: newReleaseResponseModel)
                                })}
                            Section {
                                FeaturedPlaylistSUI(featuredPlaylistResponse: $featuredPlaylistResponse, newReleasesSUIHeight: $featuredPlaylistSUISUIHeight)
                                    .frame(width: geometry.size.width, height: featuredPlaylistSUISUIHeight, alignment: .center)
                                    .listRowInsets(EdgeInsets())
                            } header: {
                                SectionHeaderWithButtonView(header: SectionNames.featuredPlaylist, content: {
                                    FeaturedPlayListViewAllSUI(featuredPlaylistResponse: featuredPlaylistResponse)
                                })
                            }
                            Section {
                                RecommendationsTracksSUI(recommendationsModel: $recommendationsModel, recommendationsTracksSUI: $recommendationsTracksSUI)
                                    .frame(width: geometry.size.width, height: recommendationsTracksSUI, alignment: .center)
                                    .listRowInsets(EdgeInsets())
                            } header: {
                                SectionHeaderWithButtonView(header: SectionNames.recomendations, content: {
                                    RecommendationsTracksViewAllSUI(recommendationsModel: recommendationsModel)
                                })
                            }
                        }
                    }
                    .listStyle(.insetGrouped) //to hide expand collaps of section
                    .padding(.zero)
                    .onAppear(perform: {
                        isLoading = false
                        showErrorView = false
                    })
                    .navigationTitle(StringConstants.browse)
                }
            }
        }
    }
}

struct HomeViewSUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSUI()
    }
}
