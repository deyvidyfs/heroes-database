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
            Group {
                TabView {
                    CharacterDatabaseView(viewModel: CharacterDatabaseViewModel())
                        .tabItem {
                            Label("Characters", systemImage: "list.dash")
                        }
                    
                    FavoriteCharactersView(viewModel: FavoriteCharactersViewModel())
                        .tabItem {
                            Label("Favorites", systemImage: "star.fill")
                        }
                }
                .modifier(TabBarModifier()) // Apply the custom modifier to TabView
            }
        }
    }
}

struct TabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor.black // Set your tab bar background color here
                
                // To change the tab bar item appearance:
                appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.marvelRed)
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]

                // Set these appearances for different tab bar states if needed
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
    }
}
