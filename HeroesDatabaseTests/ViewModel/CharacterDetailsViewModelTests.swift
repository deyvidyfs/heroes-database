//
//  CharacterDetailsViewModelTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class CharacterDetailsViewModelTests: XCTestCase {

    var mockRepository: MockCharactersRepository!
    var character: Character!
    var viewModel: CharacterDetailsViewModel!

    override func setUpWithError() throws {
        // Initialize the mock repository and character
        mockRepository = MockCharactersRepository()
        character = Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // Initialize the view model
        viewModel = CharacterDetailsViewModel(charactersRepository: mockRepository, character: character)
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        mockRepository = nil
        viewModel = nil
        character = nil
    }
    
    // Test the character description when it's provided
    func testCharacterDescriptionWithContent() throws {
        // Given: The character has a valid description
        XCTAssertEqual(viewModel.characterDescription, "Friendly Neighborhood Spider-Man")
    }
    
    // Test the character description when it's empty
    func testCharacterDescriptionWhenEmpty() throws {
        // Given: The character has an empty description
        character = Character(id: "101", name: "Spider-Man", description: "", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // Initialize the view model with the character that has an empty description
        viewModel = CharacterDetailsViewModel(charactersRepository: mockRepository, character: character)
        
        // Then: The description should be "[REDACTED]"
        XCTAssertEqual(viewModel.characterDescription, "[REDACTED]")
    }
    
    // Test the handleMarkAsFavorite function to remove a character from favorites
    func testHandleMarkAsFavoriteDeletesCharacter() async throws {
        // Given: The character is initially favorited
        viewModel.isFavorited = true
        
        // When: The character is unfavorited
        await viewModel.handleMarkAsFavorite()
        
        // Then: The character should be removed from favorites
        XCTAssertFalse(viewModel.isFavorited)
    }
}
