//
//  MockCharactersService.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
@testable import HeroesDatabase

// Mock CharactersService for testing purposes
class MockCharactersService: CharactersServiceProtocol {
    
    func fetchAllCharacters(page: Int) async throws -> [CharacterResponse] {
        // Return the mock character list for testing
        return MockCharacterResponse.sampleList
    }

    func fetchSearchedCharacters(query: String, page: Int) async throws -> [CharacterResponse] {
        // Return the mock character list filtered by the query
        return MockCharacterResponse.sampleList.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}
