//
//  ImageLoaderView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import SwiftUI

struct ImageLoaderView: View {
    
    let imageUrl: String
    let notAvailableURL = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg"
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { imageResponse in
            // TODO: Improve this conditional
            if let image = imageResponse.image, imageUrl != notAvailableURL {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .font(.system(size: 20))
                    .clipped()
            } else if imageResponse.error != nil ||
                        imageUrl.isEmpty ||
                        imageUrl == notAvailableURL {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.marvelRed)
                    Image(.marvelLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                }
            } else {
                LoadingView()
            }
        }
    }
}

#Preview {
    ImageLoaderView(imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")
}
