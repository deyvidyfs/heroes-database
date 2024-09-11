//
//  FavoriteCharactersViewModelTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class FavoriteCharactersViewModelTests: XCTestCase {

    var mockRepository: MockCharactersRepository!
    var viewModel: FavoriteCharactersViewModel!

    override func setUpWithError() throws {
        // Initialize the mock repository and view model
        mockRepository = MockCharactersRepository()
        viewModel = FavoriteCharactersViewModel(charactersRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        mockRepository = nil
        viewModel = nil
    }

    func testGetFavoriteCharactersSuccess() async throws {
        // Given the initial state is idle
        XCTAssertEqual(viewModel.state, .idle)
        
        // When fetching favorite characters
        await viewModel.getFavoriteCharacters()
        
        // Wait for the state to update from loading to loaded
        let expectation = XCTestExpectation(description: "Wait for favorite characters to load")
        
        Task {
            while viewModel.state == .loading {
                await Task.yield() // Yield control to allow the state to update
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then the state should be loaded and the characters list should be populated
        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.charactersList.isEmpty)
        XCTAssertEqual(viewModel.charactersList.count, MockCharacterResponse.sampleList.count)
    }

    func testGetFavoriteCharactersNoResults() async throws {
        // Mock the repository to return an empty list
        let mockRepository = MockCharactersRepositoryEmpty() // Define a mock with empty results
        viewModel = FavoriteCharactersViewModel(charactersRepository: mockRepository)

        // When fetching favorite characters
        await viewModel.getFavoriteCharacters()
        
        // Wait for the state to update from loading to errorNoResults
        let expectation = XCTestExpectation(description: "Wait for no favorite characters state")
        
        Task {
            while viewModel.state == .loading {
                await Task.yield() // Yield control to allow the state to update
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then the state should be errorNoResults and the characters list should be empty
        XCTAssertEqual(viewModel.state, .errorNoResults)
        XCTAssertTrue(viewModel.charactersList.isEmpty)
    }

    func testGetFavoriteCharactersError() async throws {
        // Mock the repository to throw an error
        let mockRepository = MockCharactersRepositoryError() // Define a mock with error behavior
        viewModel = FavoriteCharactersViewModel(charactersRepository: mockRepository)
        
        // When fetching favorite characters
        await viewModel.getFavoriteCharacters()
        
        // Wait for the state to update from loading to error
        let expectation = XCTestExpectation(description: "Wait for error state")
        
        Task {
            while viewModel.state == .loading {
                await Task.yield() // Yield control to allow the state to update
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then the state should be error and the characters list should be empty
        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.charactersList.isEmpty)
    }
}
