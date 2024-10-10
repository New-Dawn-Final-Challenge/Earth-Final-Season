//
//  GameStateMachine.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 10/10/24.
//

import Foundation

class GameStateMachine {
    var viewModel: GameplayViewModel
    var gameState: GameState?
    var eventsSequence: [String] = []
    var events = [Event]()
    
    init() {
        events = loadAndReturnEvents()
    }
    
    func update() {
        switch(gameState) {
        case .initializing:
            resetGame()
            
        case .choosing:
            
        case .consequence:
            
        case .gameover:
            
        case .none:
            <#code#>
        }
    }
    
    // viewmodel n precisa saber a lista toda, so o 1o
    @MainActor func resetGame() {
        viewModel.indicators = Indicators(audience: 5, illBeing: 6, socioPoliticalInstability: 6, environmentalDegradation: 6, currentYear: 0)
        viewModel.isGameOver = false
        let shuffledEvents = events.shuffled()
        eventsSequence = shuffledEvents.map { $0.id }
        viewModel.currentEvent = shuffledEvents.first
        viewModel.eventsPassedCount = 0
    }
}
