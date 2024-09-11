//
//  MockFetchCharactersResponse.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
@testable import HeroesDatabase

// Mock data for CharacterThumbnailResponse
struct MockCharacterThumbnailResponse {
    static let sample = CharacterThumbnailResponse(path: "https://example.com/image", extension: "jpg")
}

// Mock data for CharacterResponse
struct MockCharacterResponse {
    static let sample = CharacterResponse(
        id: 101,
        name: "Mock Character",
        description: "A mock description for the character.",
        thumbnail: MockCharacterThumbnailResponse.sample
    )
    
    static let sampleList = [
        CharacterResponse(
            id: 102,
            name: "Mock Character 2",
            description: "Another mock description.",
            thumbnail: MockCharacterThumbnailResponse.sample
        ),
        CharacterResponse(
            id: 103,
            name: "Mock Character 3",
            description: "Yet another mock description.",
            thumbnail: MockCharacterThumbnailResponse.sample
        )
    ]
}

// Mock data for FetchCharactersDataResponse
struct MockFetchCharactersDataResponse {
    static let sample = FetchCharactersDataResponse(results: MockCharacterResponse.sampleList)
}

// Mock data for FetchCharactersResponse
struct MockFetchCharactersResponse {
    static let sample = FetchCharactersResponse(data: MockFetchCharactersDataResponse.sample)
}

// Mock data for SearchCharactersResponse
struct MockSearchCharactersResponse {
    static let sample = SearchCharactersResponse(data: MockFetchCharactersDataResponse.sample)
}
