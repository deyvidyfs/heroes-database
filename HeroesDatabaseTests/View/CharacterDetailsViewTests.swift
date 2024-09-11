//
//  CharacterDetailsViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class CharacterDetailsViewSnapshotTests: XCTestCase {

    var viewModel: CharacterDetailsViewModel!

    override func setUpWithError() throws {
        // Initialize the mock view model
        viewModel = CharacterDetailsViewModel(charactersRepository: MockCharactersRepository(),character: Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg"))
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        viewModel = nil
    }

    // Test the snapshot for the default state (character details loaded, not favorited)
    func testCharacterDetailsViewDefaultState() {
        // Given the character details are loaded and the character is not favorited
        viewModel.isFavorited = false
        
        // Create the view
        let view = CharacterDetailsView(viewModel: viewModel)
        
        // Verify the snapshot for the default state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the favorited state
    func testCharacterDetailsViewFavoritedState() {
        // Given the character is marked as favorited
        viewModel.isFavorited = true
        
        // Create the view
        let view = CharacterDetailsView(viewModel: viewModel)
        
        // Verify the snapshot for the favorited state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the character with a redacted description (empty description)
    func testCharacterDetailsViewRedactedDescription() {
        // Given the character has an empty description
        viewModel.character = Character(id: "101", name: "Spider-Man", description: "", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // Create the view
        let view = CharacterDetailsView(viewModel: viewModel)
        
        // Verify the snapshot for the redacted description state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
