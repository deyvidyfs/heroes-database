//
//  HeroesDatabaseApp.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import SwiftUI

@main
struct HeroesDatabaseApp: App {
    
    init() {
        AppSecrets.getKeys()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
