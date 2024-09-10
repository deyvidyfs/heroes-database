//
//  CharacterDetailsViewModel.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation

protocol CharacterDetailsViewModelProtocol: ObservableObject {
    var isFavorited: Bool { get }

    var character: Character { get }
    var characterDescription: String { get }
    
    func handleMarkAsFavorite() async
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    private let charactersRepository: CharactersRepositoryProtocol
    
    var characterDescription: String {
        character.description.isEmpty ? "[REDACTED]" : character.description
    }
    
    @Published var isFavorited: Bool = false
    @Published var character: Character
    
    init(charactersRepository: CharactersRepositoryProtocol = HeroesDatabase.shared.repository,
         character: Character) {
        self.charactersRepository = charactersRepository
        self.character = character
        
        Task {
            await checkIfCharacterIsSaved()
        }
    }
    
    func handleMarkAsFavorite() async {
        if !isFavorited {
            await saveFavoriteCharacter()
        } else {
            await deleteFavoriteCharacter()
        }
        
        await checkIfCharacterIsSaved()
    }
    
    func checkIfCharacterIsSaved() async {
        do {
            if let _ = try await charactersRepository.getFavoriteCharacter(byId: character.id) {
                self.isFavorited = true
            } else {
                self.isFavorited = false
            }
        } catch {
            print("Error retrieving character: \(error)")
        }
    }
    
    func saveFavoriteCharacter() async {
        do {
            try await charactersRepository.saveFavoriteCharacter(character)
        } catch {
            print("Error saving character: \(error)")
        }
    }
    
    func deleteFavoriteCharacter() async {
        do {
            try await charactersRepository.deleteFavoriteCharacter(byId: character.id)
        } catch {
            print("Error deleting character: \(error)")
        }
    }
}
