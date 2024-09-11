//
//  CharactersRepository.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation
import RealmSwift

protocol CharactersRepositoryProtocol {
    func fetchAllCharacters(page: Int) async throws -> [Character]
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character]
    
    func getFavoriteCharacters() async throws -> [Character]
    func getFavoriteCharacter(byId id: String) async throws -> Character?
    
    func saveFavoriteCharacter(_ character: Character) async throws
    func deleteFavoriteCharacter(byId id: String) async throws
}

class CharactersRepository: CharactersRepositoryProtocol {
    private let charactersService: CharactersServiceProtocol
    private let realm: Realm
    
    init(charactersService: CharactersServiceProtocol, realm: Realm = try! Realm()) {
        self.charactersService = charactersService
        self.realm = realm
    }
    
    // MARK: - Remote Data
    
    func fetchAllCharacters(page: Int) async throws -> [Character] {
        let charactersResponse = try await charactersService.fetchAllCharacters(page: page)
        
        return charactersResponse.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)"
            )
        }
    }
    
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character] {
        let charactersResponse = try await charactersService.fetchSearchedCharacters(query: query, page: page)
        
        return charactersResponse.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)"
            )
        }
    }
    
    // MARK: - Local Data
    
    func getFavoriteCharacters() async throws -> [Character] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                let results = self.realm.objects(CharacterEntity.self)
                let characters = results.map { $0.toCharacter() }
                continuation.resume(returning: Array(characters))
            }
        }
    }
    
    func getFavoriteCharacter(byId id: String) async throws -> Character? {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                if let realmCharacter = self.realm.object(ofType: CharacterEntity.self, forPrimaryKey: id) {
                    continuation.resume(returning: realmCharacter.toCharacter())
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    func saveFavoriteCharacter(_ character: Character) async throws {
        let realmCharacter = CharacterEntity(from: character)
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                do {
                    try self.realm.write {
                        self.realm.add(realmCharacter, update: .modified)
                    }
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func deleteFavoriteCharacter(byId id: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                do {
                    if let characterToDelete = self.realm.object(ofType: CharacterEntity.self, forPrimaryKey: id) {
                        try self.realm.write {
                            self.realm.delete(characterToDelete)
                        }
                    }
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
