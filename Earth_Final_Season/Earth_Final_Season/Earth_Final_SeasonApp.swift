//
//  Earth_Final_SeasonApp.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import SwiftUI

@main
struct Earth_Final_SeasonApp: App {
    @StateObject var gameplayViewModel = GameplayViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameplayView()
                    .environmentObject(gameplayViewModel)
            }
        }
    }
}
