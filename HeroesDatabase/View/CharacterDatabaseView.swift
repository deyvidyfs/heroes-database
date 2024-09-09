//
//  CharacterDatabaseView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

struct CharacterDatabaseView<ViewModel>: View where ViewModel: CharacterDatabaseViewModelProtocol {

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
                              retryAction: {
                        Task {
                            viewModel.fetchAllCharacters
                        }
                    } )
                }
            }
            .background(Color.marvelGray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                if viewModel.state != .loaded {
                    await viewModel.fetchAllCharacters()
                }
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
                
                NavigationLink(destination: FavoriteCharactersView()) {
                    ZStack {
                        Circle()
                            .frame(width: 45, height: 45)
                            .tint(Color.marvelBlue)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .tint(.white)
                    }
                    .padding(.trailing)
                }
            }

            Text("Character Database")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $viewModel.query)
                    .onChange(of: viewModel.query, perform: { _ in
                        Task {
                            await viewModel.fetchSearchedCharacters(query: viewModel.query)
                        }
                    })
                    
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.marvelRed)
    }
    
    @ViewBuilder
    func makeCharactersList() -> some View {
        List {
            ForEach(viewModel.charactersList) { character in
                CharacterListItemView(character: character, handleMarkAsFavorite: { })
                    .listRowBackground(Color.marvelGray)
            }
            
            if viewModel.nextPageAvailable {
                LoadingView(text: "Retrieving database....")
                    .frame(maxWidth: .infinity, maxHeight: 75)
                    .listRowBackground(Color.marvelGray)
                    .onAppear {
                        Task {
                            await viewModel.fetchNextPage()
                        }
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    let service = CharactersService()
    let useCase = FetchCharactersUseCase(charactersService: service)
    let viewModel = CharacterDatabaseViewModel(fetchCharactersUseCase: useCase)
    return CharacterDatabaseView(viewModel: viewModel)
}
