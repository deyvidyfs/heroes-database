//
//  FavoriteCharactersViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class FavoriteCharactersViewSnapshotTests: XCTestCase {

    var viewModel: MockFavoriteCharactersViewModel!

    override func setUpWithError() throws {
        // Initialize the mock view model
        viewModel = MockFavoriteCharactersViewModel()
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        viewModel = nil
    }

    // Test the snapshot for the loading state
    func testFavoriteCharactersViewLoadingState() {
        // Given the view model is in the loading state
        viewModel.state = .loading
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the loading state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the loaded state
    func testFavoriteCharactersViewLoadedState() {
        // Given the view model is in the loaded state with some favorite characters
        viewModel.state = .loaded
        viewModel.charactersList = MockCharacterResponse.sampleList.map {
            Character(id: String($0.id), name: $0.name, description: $0.description, imageUrl: $0.thumbnail.path, landscapeImageUrl: $0.thumbnail.path)
        }
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the loaded state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the error state
    func testFavoriteCharactersViewErrorState() {
        // Given the view model is in the error state
        viewModel.state = .error
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the error state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the errorNoNetwork state
    func testFavoriteCharactersViewErrorNoNetworkState() {
        // Given the view model is in the errorNoNetwork state
        viewModel.state = .errorNoNetwork
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the errorNoNetwork state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the errorNoResults state
    func testFavoriteCharactersViewErrorNoResultsState() {
        // Given the view model is in the errorNoResults state
        viewModel.state = .errorNoResults
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the errorNoResults state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the idle state
    func testFavoriteCharactersViewIdleState() {
        // Given the view model is in the idle state
        viewModel.state = .idle
        
        // Create the view
        let view = FavoriteCharactersView(viewModel: viewModel)
        
        // Verify the snapshot for the idle state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
