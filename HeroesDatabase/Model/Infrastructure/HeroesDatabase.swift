//
//  HeroesDatabase.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation

final class HeroesDatabase {
    
    static var shared: HeroesDatabase!
    
    let service: CharactersServiceProtocol
    let repository: CharactersRepositoryProtocol
    
    init(service: CharactersServiceProtocol? = nil,
         repository: CharactersRepositoryProtocol? = nil) {
        self.service = service ?? CharactersService()
        self.repository = repository ?? CharactersRepository(charactersService: self.service)
        
        HeroesDatabase.shared = self
    }
}
