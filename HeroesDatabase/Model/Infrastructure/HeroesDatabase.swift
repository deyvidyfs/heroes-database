//
//  HeroesDatabase.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation

final class HeroesDatabase {
    
    static let shared = HeroesDatabase()
    
    let service: CharactersServiceProtocol
    let repository: CharactersRepositoryProtocol
    
    private init() {
        self.service = CharactersService()
        self.repository = CharactersRepository(charactersService: self.service)
    }
}
