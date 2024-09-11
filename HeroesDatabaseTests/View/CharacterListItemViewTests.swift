//
//  CharacterListItemViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class CharacterListItemViewSnapshotTests: XCTestCase {

    var viewModel: CharacterListItemViewModel!

    override func setUpWithError() throws {
        // Initialize the mock view model
        viewModel = CharacterListItemViewModel(charactersRepository: MockCharactersRepository(), character: Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg"))
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        viewModel = nil
    }

    // Test the snapshot for the default state (not favorited)
    func testCharacterListItemViewDefaultState() {
        // Given the character is not favorited
        viewModel.isFavorited = false
        
        // Create the view
        let view = CharacterListItemView(viewModel: viewModel)
        
        // Verify the snapshot for the default state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the favorited state
    func testCharacterListItemViewFavoritedState() {
        // Given the character is marked as favorited
        viewModel.isFavorited = true
        
        // Create the view
        let view = CharacterListItemView(viewModel: viewModel)
        
        // Verify the snapshot for the favorited state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
