//
//  NewReleasesSUI.swift
//  SpotifySwiftUI
//
//  Created by Ajay Girolkar on 19/12/21.
//

import SwiftUI

struct NewReleasesSUI: View {
    @State var isLoading: Bool = true
    @State var showErrorView: Bool = false
    @Binding var newReleaseResponseModel: NewReleaseResponseModel
    @State var observableNewReleaseModel = ObservableNewReleaseModel()
    let itemWidth = UIScreen.main.bounds.width * 0.7
    @Binding var newReleasesSUIHeight: CGFloat
    @State var colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: $isLoading) {
                HStack {
                    if !showErrorView {
                        addGridView()
                    }
                }.onAppear {
                    fetchNewReleasesData()
                }
                .ignoresSafeArea()
                .padding(.zero)
                .frame(width: geometry.size.width, height: 450, alignment: .center)
                .onReceive(observableNewReleaseModel.$newReleaseModel) { newReleaseModel in
                    self.newReleaseResponseModel = newReleaseModel
                    decideColumnNumber()
                }
            }
        }
    }
    
    func decideColumnNumber() {
        let totalItems = newReleaseResponseModel.albums.items.count
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
                    ForEach(newReleaseResponseModel.albums.items) { albumItem in
                        NavigationLink(destination:  CustomText(text:"\(albumItem.name)")){
                            NewReleaseAlbumInfoView(album: albumItem)
                                .frame(width: itemWidth, height: newReleasesSUIHeight - 20, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle()) //to hide blue color of text
                    }
                }.padding()
            })
        }
    }
    
    func fetchNewReleasesData() {
        APICaller.shared.getNewReleases { result in
            switch result {
            case .success(let newReleaseResponseModel):
                DispatchQueue.main.async {
                    observableNewReleaseModel.newReleaseModel = newReleaseResponseModel
                    isLoading = false
                }
            case .failure(let error):
                print(ErrorMessage.fetchNewReleasesDataError + "\(error)")
                isLoading = false
                showErrorView = true
            }
        }
    }
}

struct NewReleasesSUI_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasesSUI(newReleaseResponseModel: .constant(DefautlValues.newReleaseResponseModel), newReleasesSUIHeight: .constant(300))
    }
}
