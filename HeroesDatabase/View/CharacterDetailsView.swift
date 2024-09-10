//
//  CharacterDetailsView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 09/09/24.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
             makeHeader()

            
            VStack(spacing: 0) {
                makeSubHeader()
            }
            .background(Color.marvelRed)
            
            Text("About")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .padding()
            
            Text(viewModel.characterDescription)
            .font(.body)
            .foregroundStyle(.white)
            .padding(.horizontal)
            
            Spacer()
        }
        .toolbarBackground(Color.marvelRed, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(Color.marvelGray)
    }
    
    @ViewBuilder
    func makeHeader() -> some View {
        ZStack(alignment: .topTrailing) {
            ImageLoaderView(imageUrl: viewModel.character.landscapeImageUrl)
                .frame(maxWidth: .infinity, maxHeight: 220)
            
            VStack {
                ShareLink(item: viewModel.character.landscapeImageUrl) {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .tint(.black)
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 23, height: 30)
                            .padding()
                    }
                }
                
                Button {
                    Task {
                        await viewModel.handleMarkAsFavorite()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .tint(.black)
                            .frame(width: 50, height: 50)
                            
                        
                        Image(systemName: viewModel.isFavorited ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(viewModel.isFavorited ? .red : .white)
                    }
                }
                .padding(.horizontal)
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
            }
        }
    }
    
    @ViewBuilder
    func makeSubHeader() -> some View {
        HStack (alignment: .center) {
            ImageLoaderView(imageUrl: viewModel.character.imageUrl)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .padding(.trailing, 12)
            
            Text(viewModel.character.name)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let character = Character(id: "ABC",
                              name: "Doctor Doom",
                              description: "The Illest of Villains",
                              imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/standard_medium.jpg",
                              landscapeImageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")
    
    let viewModel = CharacterDetailsViewModel(character: character)
    return CharacterDetailsView(viewModel: viewModel)
}
