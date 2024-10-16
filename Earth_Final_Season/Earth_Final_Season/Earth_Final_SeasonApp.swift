//
//  Earth_Final_SeasonApp.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import SwiftUI

@main
struct Earth_Final_SeasonApp: App {
    @State private var gameplayVM: GameplayViewModel
    @State private var gameEngine:GameEngine
    @State private var chaosIndicatorsVM: ChaosIndicatorsViewModel

    init() {
        let gameplayViewModel = GameplayViewModel()
        let engine = GameEngine(delegate: gameplayViewModel)
        _chaosIndicatorsVM = State(wrappedValue: ChaosIndicatorsViewModel(gameplayVM: gameplayViewModel, gameEngine: engine))
        _gameEngine = State(wrappedValue: engine)
        _gameplayVM = State(wrappedValue: gameplayViewModel)
        gameplayVM.engine = engine
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(gameEngine)
                .environment(gameplayVM)
                .environment(chaosIndicatorsVM)
            .task {
                SoundtrackAudioManager.shared.playSoundtrack(named: "lowtoneST")
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
