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
                              imageUrl: "",
                              landscapeImageUrl: "")
    
    return CharacterDetailsView(character: character)
}
