//
//  FavoriteCharactersViewModel.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 09/09/24.
//

import Foundation

protocol FavoriteCharactersViewModelProtocol: ObservableObject {
    var charactersList: [Character] { get }
    var state: ResponseState { get }
    
    func getFavoriteCharacters() async
}

class FavoriteCharactersViewModel: FavoriteCharactersViewModelProtocol {
    private let charactersRepository: CharactersRepositoryProtocol

    @Published var charactersList: [Character] = []
    @Published var state: ResponseState = .idle
    
    init(charactersRepository: CharactersRepositoryProtocol = HeroesDatabase.shared.repository) {
        self.charactersRepository = charactersRepository
    }
    
    func getFavoriteCharacters() async {
        state = .loading
        
        do {
            let allCharacters = try await charactersRepository.getFavoriteCharacters()
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                !allCharacters.isEmpty else {
                    self?.state = .errorNoResults
                    return
                }
                
                self.charactersList = allCharacters
                state = .loaded
            }
        } catch {
            print("Error fetching characters: \(error)")
            state = .error
        }
    }
}
