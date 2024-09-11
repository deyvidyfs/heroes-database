//
//  CharacterEntityTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import RealmSwift
@testable import HeroesDatabase

final class CharacterEntityTests: XCTestCase {
    
    var realm: Realm!

    override func setUpWithError() throws {
        // Use an in-memory Realm for testing
        let config = Realm.Configuration(inMemoryIdentifier: "CharacterEntityTests")
        realm = try Realm(configuration: config)
    }

    override func tearDownWithError() throws {
        // Clean up Realm after each test
        try realm.write {
            realm.deleteAll()
        }
        realm = nil
    }

    func testCharacterEntityInitialization() throws {
        // Given a Character model
        let character = Character(id: "101", name: "Spider-Man", description: "Friendly Neighborhood Spider-Man", imageUrl: "https://example.com/spiderman.jpg", landscapeImageUrl: "https://example.com/spiderman_landscape.jpg")
        
        // When initializing CharacterEntity from Character
        let characterEntity = CharacterEntity(from: character)
        
        // Then assert the CharacterEntity fields are correctly populated
        XCTAssertEqual(characterEntity.id, character.id)
        XCTAssertEqual(characterEntity.name, character.name)
        XCTAssertEqual(characterEntity.characterDescription, character.description)
        XCTAssertEqual(characterEntity.imageUrl, character.imageUrl)
        XCTAssertEqual(characterEntity.landscapeImageUrl, character.landscapeImageUrl)
    }
    
    func testCharacterEntityToCharacterConversion() throws {
        // Given a CharacterEntity object
        let characterEntity = CharacterEntity()
        characterEntity.id = "101"
        characterEntity.name = "Spider-Man"
        characterEntity.characterDescription = "Friendly Neighborhood Spider-Man"
        characterEntity.imageUrl = "https://example.com/spiderman.jpg"
        characterEntity.landscapeImageUrl = "https://example.com/spiderman_landscape.jpg"
        
        // When converting CharacterEntity to Character
        let character = characterEntity.toCharacter()
        
        // Then assert the Character fields match the CharacterEntity fields
        XCTAssertEqual(character.id, characterEntity.id)
        XCTAssertEqual(character.name, characterEntity.name)
        XCTAssertEqual(character.description, characterEntity.characterDescription)
        XCTAssertEqual(character.imageUrl, characterEntity.imageUrl)
        XCTAssertEqual(character.landscapeImageUrl, characterEntity.landscapeImageUrl)
    }
    
    func testCharacterEntityPersistence() throws {
        // Given a Character model and a CharacterEntity object
        let character = Character(id: "102", name: "Iron Man", description: "Genius Billionaire", imageUrl: "https://example.com/ironman.jpg", landscapeImageUrl: "https://example.com/ironman_landscape.jpg")
        let characterEntity = CharacterEntity(from: character)
        
        // When saving the CharacterEntity to Realm
        try realm.write {
            realm.add(characterEntity)
        }
        
        // Then assert the CharacterEntity can be retrieved from Realm
        let fetchedCharacterEntity = realm.object(ofType: CharacterEntity.self, forPrimaryKey: "102")
        XCTAssertNotNil(fetchedCharacterEntity)
        XCTAssertEqual(fetchedCharacterEntity?.id, character.id)
        XCTAssertEqual(fetchedCharacterEntity?.name, character.name)
        XCTAssertEqual(fetchedCharacterEntity?.characterDescription, character.description)
        XCTAssertEqual(fetchedCharacterEntity?.imageUrl, character.imageUrl)
        XCTAssertEqual(fetchedCharacterEntity?.landscapeImageUrl, character.landscapeImageUrl)
    }
}
