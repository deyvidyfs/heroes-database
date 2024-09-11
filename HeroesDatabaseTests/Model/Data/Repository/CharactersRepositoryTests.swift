//
//  CharactersRepositoryTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import RealmSwift
@testable import HeroesDatabase

final class CharactersRepositoryTests: XCTestCase {

    var mockService: MockCharactersService!
    var charactersRepository: CharactersRepository!
    var realm: Realm!
    
    override func setUpWithError() throws {
        // Initialize the mock service
        mockService = MockCharactersService()
        
        // Set up in-memory Realm
        let config = Realm.Configuration(inMemoryIdentifier: "CharactersRepositoryTests")
        realm = try Realm(configuration: config)
        
        // Initialize the repository with the mock service and in-memory Realm
        charactersRepository = CharactersRepository(charactersService: mockService, realm: realm)
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        mockService = nil
        charactersRepository = nil
        realm = nil
    }

    // Test methods remain the same, but now they will use the injected in-memory Realm
    
    func testSaveAndRetrieveFavoriteCharacter() async throws {
        // Given a character to save
        let character = Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // When saving the character
        try await charactersRepository.saveFavoriteCharacter(character)
        
        // Then retrieve the saved character from Realm
        let savedCharacter = try await charactersRepository.getFavoriteCharacter(byId: character.id)
        
        // Assert the character was saved and retrieved correctly
        XCTAssertNotNil(savedCharacter)
        XCTAssertEqual(savedCharacter?.name, character.name)
    }
    
    func testDeleteFavoriteCharacter() async throws {
        // Given a character to save and then delete
        let character = Character(id: "102", name: "Iron Man", description: "Genius Billionaire", imageUrl: "https://example.com/ironman.jpg", landscapeImageUrl: "https://example.com/ironman_landscape.jpg")
        
        // Save the character
        try await charactersRepository.saveFavoriteCharacter(character)
        
        // Delete the character
        try await charactersRepository.deleteFavoriteCharacter(byId: character.id)
        
        // Then assert the character was deleted
        let deletedCharacter = try await charactersRepository.getFavoriteCharacter(byId: character.id)
        XCTAssertNil(deletedCharacter)
    }
    
    func testGetAllFavoriteCharacters() async throws {
        // Given some favorite characters to save
        let character1 = Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        let character2 = Character(id: "102", name: "Iron Man", description: "Genius Billionaire", imageUrl: "https://example.com/ironman.jpg", landscapeImageUrl: "https://example.com/ironman_landscape.jpg")
        
        // Save the characters
        try await charactersRepository.saveFavoriteCharacter(character1)
        try await charactersRepository.saveFavoriteCharacter(character2)
        
        // When retrieving all favorite characters
        let favoriteCharacters = try await charactersRepository.getFavoriteCharacters()
        
        // Assert the favorite characters were retrieved correctly
        XCTAssertEqual(favoriteCharacters.count, 2)
        
        // Sort by name to ensure consistent ordering
        let sortedFavorites = favoriteCharacters.sorted(by: { $0.name < $1.name })
        
        XCTAssertEqual(sortedFavorites[0].name, "Iron Man")
        XCTAssertEqual(sortedFavorites[1].name, "Spider-Man")
    }
}
