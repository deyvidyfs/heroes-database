//
//  MockFavoriteCharactersViewModel.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import Foundation
@testable import HeroesDatabase

class MockFavoriteCharactersViewModel: FavoriteCharactersViewModelProtocol, ObservableObject {

    @Published var state: ResponseState = .idle
    @Published var charactersList: [Character] = []

    func getFavoriteCharacters() async {
        // Mock fetching favorite characters
    }
}
