//
//  CharacterEntity.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
import RealmSwift

class CharacterEntity: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var characterDescription: String = ""
    @Persisted var imageUrl: String = ""
    @Persisted var landscapeImageUrl: String = ""

    convenience init(from character: Character) {
        self.init()
        self.id = character.id
        self.name = character.name
        self.characterDescription = character.description
        self.imageUrl = character.imageUrl
        self.landscapeImageUrl = character.landscapeImageUrl
    }
    
    func toCharacter() -> Character {
        return Character(id: id,
                         name: name,
                         description: characterDescription,
                         imageUrl: imageUrl,
                         landscapeImageUrl: landscapeImageUrl)
    }
}
