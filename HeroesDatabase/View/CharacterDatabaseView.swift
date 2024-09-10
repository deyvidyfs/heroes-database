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
                            await viewModel.fetchAllCharacters()
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
            Image(.marvelLogo)
                .resizable()
                .frame(width: 92, height: 37)
                .padding()

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
                CharacterListItemView(viewModel: CharacterListItemViewModel(character: character))
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
    CharacterDatabaseView(viewModel: CharacterDatabaseViewModel())
}
