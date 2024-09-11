//
//  CharacterDatabaseViewModelTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class CharacterDatabaseViewModelTests: XCTestCase {

    var mockRepository: MockCharactersRepository!
    var viewModel: CharacterDatabaseViewModel!

    override func setUpWithError() throws {
        // Initialize the mock repository and view model
        mockRepository = MockCharactersRepository()
        viewModel = CharacterDatabaseViewModel(charactersRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        mockRepository = nil
        viewModel = nil
    }

    func testFetchAllCharactersSuccess() async throws {
        // Given an initial idle state
        XCTAssertEqual(viewModel.state, .idle)
        
        // When fetching all characters
        await viewModel.fetchAllCharacters()
        
        // Then the state should change to loaded and the characters list should be populated
        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.charactersList.isEmpty)
        XCTAssertEqual(viewModel.charactersList.count, MockCharacterResponse.sampleList.count)
    }

    func testFetchSearchedCharactersSuccess() async throws {
        // Given a valid query
        let query = "Mock Character"
        
        // When fetching searched characters
        await viewModel.fetchSearchedCharacters(query: query)
        
        // Wait for the state to update from loading to loaded
        let expectation = XCTestExpectation(description: "Wait for characters to load")
        
        let task = Task {
            while viewModel.state == .loading {
                await Task.yield() // Yield control to allow the state to update
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        // Then the state should change to loaded and the characters list should contain matching results
        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.charactersList.isEmpty)
        XCTAssertTrue(viewModel.charactersList.allSatisfy { $0.name.lowercased().contains(query.lowercased()) })
    }

    func testFetchSearchedCharactersNoResults() async throws {
        // Given a query that doesn't match any characters
        let query = "NonExistentCharacter"
        
        // When fetching searched characters
        await viewModel.fetchSearchedCharacters(query: query)
        
        // Wait for the state to update from loading to errorNoResults
        let expectation = XCTestExpectation(description: "Wait for no results state")
        
        let task = Task {
            while viewModel.state == .loading {
                await Task.yield() // Yield control to allow the state to update
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        // Then the state should change to errorNoResults and the characters list should be empty
        XCTAssertEqual(viewModel.state, .errorNoResults)
        XCTAssertTrue(viewModel.charactersList.isEmpty)
    }

    func testFetchNextPageSuccess() async throws {
        // Given that the first page of characters has already been loaded
        await viewModel.fetchAllCharacters()
        XCTAssertEqual(viewModel.state, .loaded)
        let initialCount = viewModel.charactersList.count
        
        // When fetching the next page of characters
        await viewModel.fetchNextPage()
        
        // Then the characters list should grow
        XCTAssertEqual(viewModel.charactersList.count, initialCount * 2)
    }
}
