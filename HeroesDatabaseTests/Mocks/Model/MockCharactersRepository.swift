//
//  MockCharactersRepository.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
@testable import HeroesDatabase

// Mock CharactersRepository for testing purposes
class MockCharactersRepository: CharactersRepositoryProtocol {
    
    // Mock fetchAllCharacters method
    func fetchAllCharacters(page: Int) async throws -> [Character] {
        return MockCharacterResponse.sampleList.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)")
        }
    }

    // Mock fetchSearchedCharacters method
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character] {
        return MockCharacterResponse.sampleList.filter { $0.name.lowercased().contains(query.lowercased()) }.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)")
        }
    }
    
    // Mock getFavoriteCharacters method
    func getFavoriteCharacters() async throws -> [Character] {
        return MockCharacterResponse.sampleList.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)")
        }
    }

    // Mock getFavoriteCharacter by id
    func getFavoriteCharacter(byId id: String) async throws -> Character? {
        return MockCharacterResponse.sampleList.first { String($0.id) == id }.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)")
        }
    }
    
    // Mock saveFavoriteCharacter method
    func saveFavoriteCharacter(_ character: Character) async throws {
        // No-op for mocking, simulates saving a favorite character
    }
    
    // Mock deleteFavoriteCharacter by id
    func deleteFavoriteCharacter(byId id: String) async throws {
        // No-op for mocking, simulates deleting a favorite character
    }
}

// Mock CharactersRepository that returns an empty list
class MockCharactersRepositoryEmpty: CharactersRepositoryProtocol {
    func getFavoriteCharacters() async throws -> [Character] {
        return []
    }

    func fetchAllCharacters(page: Int) async throws -> [Character] {
        return []
    }

    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character] {
        return []
    }

    func getFavoriteCharacter(byId id: String) async throws -> Character? {
        return nil
    }

    func saveFavoriteCharacter(_ character: Character) async throws {}
    
    func deleteFavoriteCharacter(byId id: String) async throws {}
}

// Mock CharactersRepository that throws an error
class MockCharactersRepositoryError: CharactersRepositoryProtocol {
    func getFavoriteCharacters() async throws -> [Character] {
        throw NSError(domain: "MockError", code: -1, userInfo: nil)
    }

    func fetchAllCharacters(page: Int) async throws -> [Character] {
        throw NSError(domain: "MockError", code: -1, userInfo: nil)
    }

    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character] {
        throw NSError(domain: "MockError", code: -1, userInfo: nil)
    }

    func getFavoriteCharacter(byId id: String) async throws -> Character? {
        throw NSError(domain: "MockError", code: -1, userInfo: nil)
    }

    func saveFavoriteCharacter(_ character: Character) async throws {}
    
    func deleteFavoriteCharacter(byId id: String) async throws {}
}

class MockCharactersRepositoryFavorited: CharactersRepositoryProtocol {
    func getFavoriteCharacter(byId id: String) async throws -> Character? {
        return Character(id: id, name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
    }

    func fetchAllCharacters(page: Int) async throws -> [Character] { return [] }
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [Character] { return [] }
    func getFavoriteCharacters() async throws -> [Character] { return [] }
    func saveFavoriteCharacter(_ character: Character) async throws { /* Simulate saving the character */ }
    func deleteFavoriteCharacter(byId id: String) async throws { /* Simulate deleting the character */ }
}
