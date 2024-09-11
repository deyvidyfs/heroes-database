//
//  FetchCharactersResponse.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

struct FetchCharactersResponse: Codable {
    var data: FetchCharactersDataResponse
}

struct FetchCharactersDataResponse: Codable {
    var results: [CharacterResponse]
}

struct CharacterResponse: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterThumbnailResponse
}

struct CharacterThumbnailResponse: Codable {
    var path: String
    var `extension`: String
}
