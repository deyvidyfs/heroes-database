//
//  CharactersService.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

protocol CharactersServiceProtocol {
    func fetchAllCharacters(page: Int) async throws -> [CharacterResponse]
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [CharacterResponse]
}

final class CharactersService: CharactersServiceProtocol {

    private var apiManager: APIManagerProtocol
    private var pageSize: Int = 45

    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }

    func fetchAllCharacters(page: Int) async throws -> [CharacterResponse] {
        var requestModel = FetchCharactersRequest()
        
        requestModel.queryParameters = { [
            "offset": page > 0 ? String(page*pageSize) : "0",
            "limit": String(pageSize)
        ] }()
        
        let response = try await apiManager.fetchResource(FetchCharactersResponse.self, urlRequest: apiManager.buildRequest(requestModel))
        
        return response.data.results
    }

    func fetchSearchedCharacters(query: String, page: Int) async throws -> [CharacterResponse] {
        var requestModel = SearchCharactersRequest()
        
        requestModel.queryParameters = { [
            "nameStartsWith": query,
            "offset": page > 0 ? String(page*pageSize) : "0",
            "limit": String(pageSize)
        ] }()
        
        let response = try await apiManager.fetchResource(SearchCharactersResponse.self, urlRequest: apiManager.buildRequest(requestModel))
        
        return response.data.results
    }
}
