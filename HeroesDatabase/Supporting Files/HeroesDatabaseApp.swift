//
//  HeroesDatabaseApp.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

@main
struct HeroesDatabaseApp: App {
    
    let service: CharactersServiceProtocol
    let useCase: FetchCharactersUseCaseProtocol
    
    init() {
        AppSecrets.getKeys()
        service = CharactersService()
        useCase = FetchCharactersUseCase(charactersService: service)
    }
    
    var body: some Scene {
        WindowGroup {
            CharacterDatabaseView(viewModel: CharacterDatabaseViewModel(fetchCharactersUseCase: useCase))
        }
    }
}
