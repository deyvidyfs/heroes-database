//
//  CharacterDatabaseViewModel.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation
import Reachability

protocol CharacterDatabaseViewModelProtocol: ObservableObject {
    var query: String { get set }
    var nextPageAvailable: Bool { get }
    var state: ResponseState { get }
    var charactersList: [Character] { get }
    
    func fetchAllCharacters() async
    func fetchSearchedCharacters(query: String) async
    func fetchNextPage() async
    func handleFavoriteCharacterButton()
}

class CharacterDatabaseViewModel: CharacterDatabaseViewModelProtocol {

    @Published var query: String = ""
    @Published var nextPageAvailable: Bool = true
    @Published var state: ResponseState = .idle
    @Published var charactersList: [Character] = []

    private var page = 0
    private let reachability = try? Reachability()
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var searchTask: Task<Void, Never>? = nil

    init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    @MainActor
    func fetchAllCharacters() async {
        state = .loading
        
        nextPageAvailable = true
        
        do {
            let charactersList = try await fetchCharactersUseCase.getAllCharacters(page: page)
            state = charactersList.isEmpty ? .error : .loaded
            self.charactersList = charactersList
        } catch {
            checkNetworkState()
        }
    }

    @MainActor
    func fetchNextPage() async {
        var nextPageCharactersList: [Character] = []
        page += 1

        do {
            if query.isEmpty {
                nextPageCharactersList = try await fetchCharactersUseCase.getAllCharacters(page: page)
            } else {
                nextPageCharactersList = try await fetchCharactersUseCase.getSearchedCharacters(query: query.lowercased(), page: page)
            }
            
            if !nextPageCharactersList.isEmpty {
                self.charactersList.append(contentsOf: nextPageCharactersList)
            } else {
                nextPageAvailable = false
            }
            
        } catch {
            checkNetworkState()
        }
    }

    @MainActor
    func fetchSearchedCharacters(query: String) async {
        // Cancel any previous search task before starting a new one
        searchTask?.cancel()
        page = 0
        nextPageAvailable = true

        if query.isEmpty {
            // If the query is empty, reset the page and fetch all characters
            await fetchAllCharacters()
            return
        }

        state = .loading
        
        print("QUERY: \(query)")

        // Launch a new search task
        searchTask = Task {
            do {
                let fetchedCharacters = try await fetchCharactersUseCase.getSearchedCharacters(query: query.lowercased(), page: page)

                guard !Task.isCancelled else { return } // Ensure the task wasn't canceled
                
                // Update the UI on the main thread
                await MainActor.run {
                    self.charactersList = fetchedCharacters
                    self.state = !self.charactersList.isEmpty ? .loaded : .errorNoResults
                }
            } catch {
                // Only handle errors if the task wasn't canceled
                if !Task.isCancelled {
                    await MainActor.run {
                        self.state = .error
                        checkNetworkState()
                    }
                }
                
            }
        }
    }
    
    func handleFavoriteCharacterButton() {
        // TBD
    }

    private func checkNetworkState() {
        if reachability?.connection == .unavailable {
            self.state = .errorNoNetwork
            return
        }
        self.state = .error
    }
}
