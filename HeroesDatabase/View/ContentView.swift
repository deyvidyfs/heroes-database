//
//  ContentView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let characters = try await CharactersService().fetchAllCharacters(page: 0)
                print("Characters: \(characters)")
            } catch {
                print("ERROR: ", error)
            }
        }
    }
}

#Preview {
    ContentView()
}
