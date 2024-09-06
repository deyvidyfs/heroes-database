//
//  FetchCharactersResponse.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

struct FetchCharactersResponse: Decodable {
    var data: FetchCharactersDataResponse
}

struct FetchCharactersDataResponse: Decodable {
    var results: [CharacterResponse]
}

struct CharacterResponse: Decodable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterThumbnailResponse
}

struct CharacterThumbnailResponse: Decodable {
    var path: String
    var `extension`: String
}
