//
//  CharactersServiceTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import XCTest
@testable import HeroesDatabase

final class CharactersServiceTests: XCTestCase {

    var charactersService: CharactersService!
    var mockAPIManager: MockAPIManager!

    override func setUpWithError() throws {
        // Initialize mock APIManager and CharactersService
        mockAPIManager = MockAPIManager()
        charactersService = CharactersService(apiManager: mockAPIManager)
    }

    override func tearDownWithError() throws {
        // Clean up resources
        charactersService = nil
        mockAPIManager = nil
    }

    func testFetchAllCharactersSuccess() async throws {
        // Given a valid page number
        let page = 1

        // When fetching all characters
        let characters = try await charactersService.fetchAllCharacters(page: page)

        // Then assert the fetched characters are correct
        XCTAssertEqual(characters.count, MockCharacterResponse.sampleList.count)
        XCTAssertEqual(characters.first?.name, MockCharacterResponse.sampleList.first?.name)
    }

    func testFetchAllCharactersFailure() async {
        // Given a mock API manager set to throw an error
        mockAPIManager.shouldThrowError = true
        let page = 1

        // Manually handle the async error throwing
        do {
            let _ = try await charactersService.fetchAllCharacters(page: page)
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.dataRequestError("Mock: Data fetch error"))
        }
    }

    func testFetchSearchedCharactersSuccess() async throws {
        // Given a valid search query and page number
        let query = "Mock Character"
        let page = 1

        // When searching for characters
        let characters = try await charactersService.fetchSearchedCharacters(query: query, page: page)

        // Then assert the fetched characters are filtered correctly
        XCTAssertFalse(characters.isEmpty)
        XCTAssertTrue(characters.allSatisfy { $0.name.lowercased().contains(query.lowercased()) })
    }

    func testFetchSearchedCharactersFailure() async {
        // Given a mock API manager set to throw an error
        mockAPIManager.shouldThrowError = true
        let query = "Spider-Man"
        let page = 1

        // Manually handle the async error throwing
        do {
            let _ = try await charactersService.fetchSearchedCharacters(query: query, page: page)
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.dataRequestError("Mock: Data fetch error"))
        }
    }
}
