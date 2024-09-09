//
//  CharacterListItemView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 08/09/24.
//

import SwiftUI

struct CharacterListItemView: View {
    
    let character: Character
    let handleMarkAsFavorite: () -> Void
    
    @State private var markedAsFavorite: Bool = false
    
    var body: some View {
            HStack {
                NavigationLink(destination: CharacterDetailsView(character: character)) {
                    HStack {
                        makeThumbnail()
                            .padding(.trailing, 12)
                        
                        Text(character.name)
                            .font(.title3)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                
                Button {
                    markedAsFavorite.toggle()
                    handleMarkAsFavorite()
                } label: {
                    Image(systemName: markedAsFavorite ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(markedAsFavorite ? .red : .white)
                }
                .padding(.horizontal)
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
            }
            .background(Color.marvelGray)
        }
    
    
    @ViewBuilder
    func makeThumbnail() -> some View {
        
        let notAvailableURL = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg"
        
        let imageUrl = character.imageUrl
        
        AsyncImage(url: URL(string: imageUrl)) { imageResponse in
            // TODO: Improve this conditional
            if let image = imageResponse.image, imageUrl != notAvailableURL {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 20))
                    .clipped()
                    .clipShape(Circle())
            } else if imageResponse.error != nil ||
                        imageUrl.isEmpty ||
                        imageUrl == notAvailableURL {
                ZStack {
                    Circle()
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
        .frame(width: 75, height: 75)
    }
}


#Preview {
    let character = Character(id: "ABC",
                              name: "Doctor Doom",
                              description: "The Illest of Villains",
                              imageUrl: "",
                              landscapeImageUrl: "")
    
    return CharacterListItemView(character: character, handleMarkAsFavorite: {})
}
