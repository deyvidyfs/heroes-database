//
//  CharacterListItemViewModelTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class CharacterListItemViewModelTests: XCTestCase {

    var mockRepository: MockCharactersRepository!
    var character: Character!
    var viewModel: CharacterListItemViewModel!

    override func setUpWithError() throws {
        // Initialize the mock repository and character
        mockRepository = MockCharactersRepository()
        character = Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // Initialize the view model
        viewModel = CharacterListItemViewModel(charactersRepository: mockRepository, character: character)
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        mockRepository = nil
        viewModel = nil
        character = nil
    }
    
    func testHandleMarkAsFavoriteDeletesCharacter() async throws {
        // Given the character is already favorited
        viewModel.isFavorited = true
        
        // When unmarking the character as favorite
        await viewModel.handleMarkAsFavorite()
        
        // Then the character should be removed from the repository and marked as not favorited
        XCTAssertFalse(viewModel.isFavorited)
    }
    
    func testCheckIfCharacterIsSavedWhenFavorited() async throws {
        // Mock the repository to return the character as favorited
        let mockRepository = MockCharactersRepositoryFavorited() // Define a mock where the character is favorited
        viewModel = CharacterListItemViewModel(charactersRepository: mockRepository, character: character)
        
        // When checking if the character is saved
        await viewModel.checkIfCharacterIsSaved()
        
        // Then the character should be marked as favorited
        XCTAssertTrue(viewModel.isFavorited)
    }
    
    func testCheckIfCharacterIsSavedWhenNotFavorited() async throws {
        // Mock the repository to return nil (character is not favorited)
        let mockRepository = MockCharactersRepositoryEmpty() // Define a mock where the character is not favorited
        viewModel = CharacterListItemViewModel(charactersRepository: mockRepository, character: character)
        
        // When checking if the character is saved
        await viewModel.checkIfCharacterIsSaved()
        
        // Then the character should be marked as not favorited
        XCTAssertFalse(viewModel.isFavorited)
    }
    
    func testPerformAfterActionCalled() async throws {
        // Given an after-action callback
        var callbackCalled = false
        let callback = { callbackCalled = true }
        
        // Initialize the view model with the callback
        viewModel = CharacterListItemViewModel(charactersRepository: mockRepository, character: character, performAfterAction: callback)
        
        // When marking the character as favorite
        await viewModel.handleMarkAsFavorite()
        
        // Then the after-action callback should be called
        XCTAssertTrue(callbackCalled)
    }
}
