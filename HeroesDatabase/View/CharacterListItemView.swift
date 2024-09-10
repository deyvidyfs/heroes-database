//
//  CharacterListItemView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 08/09/24.
//

import SwiftUI

struct CharacterListItemView: View {
    
    @ObservedObject var viewModel: CharacterListItemViewModel
    
    init(viewModel: CharacterListItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: viewModel.character))) {
                HStack {
                    ImageLoaderView(imageUrl: viewModel.character.imageUrl)
                        .clipShape(Circle())
                        .frame(width: 75, height: 75)
                        .padding(.trailing, 12)
                    
                    Text(viewModel.character.name)
                        .font(.title3)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            
            Button {
                Task {
                    await viewModel.handleMarkAsFavorite()
                }
            } label: {
                Image(systemName: viewModel.isFavorited ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(viewModel.isFavorited ? .red : .white)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())
        }
        .background(Color.marvelGray)
        .onAppear {
            Task {
                await viewModel.checkIfCharacterIsSaved()
            }
        }
    }
}


#Preview {
    let character = Character(id: "ABC",
                              name: "Doctor Doom",
                              description: "The Illest of Villains",
                              imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/standard_medium.jpg",
                              landscapeImageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")
    
    let viewModel = CharacterListItemViewModel(character: character, performAfterAction: {})
    
    return CharacterListItemView(viewModel: viewModel)
}
