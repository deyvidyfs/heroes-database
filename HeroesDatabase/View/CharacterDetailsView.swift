//
//  CharacterDetailsView.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 09/09/24.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    let character: Character
    
    var body: some View {
        Text("Character Details")
    }
}

#Preview {
    let character = Character(id: "ABC",
                              name: "Doctor Doom",
                              description: "The Illest of Villains",
                              imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/standard_medium.jpg",
                              landscapeImageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")
    
    return CharacterDetailsView(character: character)
}
