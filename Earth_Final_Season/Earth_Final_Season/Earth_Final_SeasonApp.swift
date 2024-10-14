//
//  Earth_Final_SeasonApp.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import SwiftUI

@main
struct Earth_Final_SeasonApp: App {
    @State private var gameplayVM = GameplayViewModel()
    @State private var chaosIndicatorsVM: ChaosIndicatorsViewModel

    init() {
        let gameplayViewModel = GameplayViewModel()
        _chaosIndicatorsVM = State(wrappedValue: ChaosIndicatorsViewModel(gameplayVM: gameplayViewModel))
        _gameplayVM = State(wrappedValue: gameplayViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(gameplayVM)
                .environment(chaosIndicatorsVM)
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
