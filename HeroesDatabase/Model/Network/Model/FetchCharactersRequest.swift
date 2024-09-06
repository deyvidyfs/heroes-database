//
//  FetchCharactersRequest.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

struct FetchCharactersRequest: RequestProtocol {
    var url: String { "https://gateway.marvel.com" }
    var path: String { "/v1/public/characters" }
    var method: String { "GET" }
    var queryParameters: [String: String]?
}
