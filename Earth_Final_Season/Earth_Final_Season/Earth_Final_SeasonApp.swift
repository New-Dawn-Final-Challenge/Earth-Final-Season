//
//  Earth_Final_SeasonApp.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import SwiftUI

@main
struct Earth_Final_SeasonApp: App {
    @State var gameplayViewModel = GameplayViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuView()
            }
            .task {
                SoundtrackAudioManager.shared.playSound(named: "lowtoneST")
            }
        }
    }
}

extension View {
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
