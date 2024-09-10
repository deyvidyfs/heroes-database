//
//  CharacterListItemViewModel.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 09/09/24.
//

import Foundation
import Combine

protocol CharacterListItemViewModelProtocol: ObservableObject {
    var character: Character { get }
    var isFavorited: Bool { get }
    
    func handleMarkAsFavorite() async
}

class CharacterListItemViewModel: CharacterListItemViewModelProtocol {
    private let charactersRepository: CharactersRepositoryProtocol
    
    @Published var character: Character
    @Published var performAfterAction: (() -> Void)?
    @Published var isFavorited: Bool = false
    
    init(charactersRepository: CharactersRepositoryProtocol = HeroesDatabase.shared.repository,
         character: Character,
         performAfterAction: (() -> Void)? = nil) {
        self.charactersRepository = charactersRepository
        self.character = character
        self.performAfterAction = performAfterAction
        
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
        performAfterAction?()
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
