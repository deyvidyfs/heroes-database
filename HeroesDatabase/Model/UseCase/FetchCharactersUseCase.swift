//
//  FetchCharactersUseCase.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func getAllCharacters(page: Int) async throws -> [Character]
    func getSearchedCharacters(query: String, page: Int) async throws -> [Character]
}

class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    
    private let charactersService: CharactersServiceProtocol

    init(charactersService: CharactersServiceProtocol) {
        self.charactersService = charactersService
    }
    
    func getAllCharacters(page: Int) async throws -> [Character] {
        let charactersResponse = try await charactersService.fetchAllCharacters(page: page)

        return charactersResponse.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)"
            )
        }
    }
    
    func getSearchedCharacters(query: String, page: Int) async throws -> [Character] {
        let charactersResponse = try await charactersService.fetchSearchedCharacters(query: query, page: page)

        return charactersResponse.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)"
            )
        }
    }
}
