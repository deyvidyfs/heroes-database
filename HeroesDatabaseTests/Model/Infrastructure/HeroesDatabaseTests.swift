//
//  HeroesDatabaseTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class HeroesDatabaseTests: XCTestCase {

    var mockService: MockCharactersService!
    var mockRepository: MockCharactersRepository!
    var heroesDatabase: HeroesDatabase!
    
    override func setUpWithError() throws {
        // Initialize mocks
        mockService = MockCharactersService()
        mockRepository = MockCharactersRepository()
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        mockService = nil
        mockRepository = nil
        heroesDatabase = nil
    }

    func testHeroesDatabaseInitializationWithDefaults() {
        // When initializing without passing any arguments
        heroesDatabase = HeroesDatabase()
        
        // Then assert the service and repository are default initialized
        XCTAssertTrue(heroesDatabase.service is CharactersService)
        XCTAssertTrue(heroesDatabase.repository is CharactersRepository)
        XCTAssertNotNil(HeroesDatabase.shared) // Ensure shared instance is set
    }
    
    func testHeroesDatabaseInitializationWithCustomServiceAndRepository() {
        // When initializing with custom service and repository
        heroesDatabase = HeroesDatabase(service: mockService, repository: mockRepository)
        
        // Then assert the injected service and repository are correctly used
        XCTAssertTrue(heroesDatabase.service is MockCharactersService)
        XCTAssertTrue(heroesDatabase.repository is MockCharactersRepository)
        XCTAssertNotNil(HeroesDatabase.shared) // Ensure shared instance is set
    }
}
