//
//  MockCharacterDatabaseViewModel.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import Foundation
@testable import HeroesDatabase

class MockCharacterDatabaseViewModel: CharacterDatabaseViewModelProtocol, ObservableObject {
    
    @Published var state: ResponseState = .idle
    @Published var charactersList: [Character] = []
    @Published var query: String = ""
    @Published var nextPageAvailable: Bool = true

    func fetchAllCharacters() async {}
    func fetchSearchedCharacters(query: String) async {}
    func fetchNextPage() async {}
}
