//
//  FavoriteCharactersView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 09/09/24.
//

import SwiftUI

struct FavoriteCharactersView<ViewModel>: View where ViewModel: FavoriteCharactersViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                makeHeaderView()
                
                switch viewModel.state {
                case .loading:
                    LoadingView(text: "Retrieving database...")
                case .loaded, .idle:
                    makeCharactersList()
                case .error, .errorNoNetwork, .errorNoResults:
                    ErrorView(errorMessage: viewModel.state.getErrorMessage(),
                              retryAction: nil )
                }
            }
            .background(Color.marvelGray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                await viewModel.getFavoriteCharacters()
            }
        }
    }
    
    @ViewBuilder
    func makeHeaderView() -> some View {
        VStack (alignment: .leading) {
            HStack {
                Image(.marvelLogo)
                    .resizable()
                    .frame(width: 92, height: 37)
                    .padding()
                
                Spacer()
            }

            Text("Favorites")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(Color.marvelRed)
    }
    
    @ViewBuilder
    func makeCharactersList() -> some View {
        List {
            ForEach(viewModel.charactersList) { character in
                CharacterListItemView(viewModel: CharacterListItemViewModel(character: character))
                    .listRowBackground(Color.marvelGray)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .refreshable {
            Task {
                await viewModel.getFavoriteCharacters()
            }
        }
    }
}

#Preview {
    FavoriteCharactersView(viewModel: FavoriteCharactersViewModel())
}
