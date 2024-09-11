//
//  CharacterTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class CharacterTests: XCTestCase {
    
    func testCharacterInitialization() {
        // Given valid character data
        let id = "101"
        let name = "Spider-Man"
        let description = "Friendly Neighborhood Spider-Man"
        let imageUrl = "https://example.com/spiderman.jpg"
        let landscapeImageUrl = "https://example.com/spiderman_landscape.jpg"
        
        // When initializing a Character object
        let character = Character(id: id, name: name, description: description, imageUrl: imageUrl, landscapeImageUrl: landscapeImageUrl)
        
        // Then assert all properties are set correctly
        XCTAssertEqual(character.id, id)
        XCTAssertEqual(character.name, name)
        XCTAssertEqual(character.description, description)
        XCTAssertEqual(character.imageUrl, imageUrl)
        XCTAssertEqual(character.landscapeImageUrl, landscapeImageUrl)
    }
}
