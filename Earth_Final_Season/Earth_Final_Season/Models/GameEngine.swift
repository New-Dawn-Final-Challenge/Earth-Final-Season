//
//  GameEngine.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 11/10/24.
//

import Foundation
import SwiftUI
import Design_System

@Observable
class GameEngine {
    weak var delegate: GameEngineDelegate?
    
    var countdown = 6
    var timer: Timer?
    var gameOverTitle = ""
    var gameOverReason = ""
    var gameOverImage: Image?
    var lastChosenOption = "choice1"
    var events = [Event]()
    var currentEvent: Event?
    var indicators = Indicators(audience: Constants.GameEngine.initialAudience,
                                illBeing: Constants.GameEngine.initialIllBeing,
                                socioPoliticalInstability: Constants.GameEngine.initialSocioPoliticalInstability,
                                environmentalDegradation: Constants.GameEngine.initialEnvironmentalDegradation,
                                currentYear: Constants.GameEngine.initialYear)  // Initial Indicators
    
    private var eventsSequence: [String] = []
    private var eventsPassedCount = 0
    
    var state: States = .initializing

    init(delegate: GameplayViewModel) {
        events = loadAndReturnEvents()
        resetGame()
        self.delegate = delegate
    }
    
    func gameEnded() -> Bool {
        return indicators.audience <= Constants.GameEngine.minAudienceThreshold ||
               indicators.environmentalDegradation >= Constants.GameEngine.maxIndicatorThreshold ||
               indicators.illBeing >= Constants.GameEngine.maxIndicatorThreshold ||
               indicators.socioPoliticalInstability >= Constants.GameEngine.maxIndicatorThreshold
    }
    
    func checkForGameOver() {
        if state == .consequence {
            if indicators.audience <= Constants.GameEngine.minAudienceThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverAudienceTitle
                    gameOverReason = Constants.GameEngine.gameOverAudienceMessage
                    gameOverImage = Assets.Images.audienceEnd.swiftUIImage
                }
                applyGameOver()
            }
            
            if indicators.environmentalDegradation >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverEnvironmentTitle
                    gameOverReason = Constants.GameEngine.gameOverEnvironmentMessage
                    gameOverImage = Assets.Images.environmentalEnd.swiftUIImage
                }
                applyGameOver()
            }
            
            if indicators.illBeing >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverIllBeingTitle
                    gameOverReason = Constants.GameEngine.gameOverIllBeingMessage
                    gameOverImage = Assets.Images.illBeingEnd.swiftUIImage
                }
                applyGameOver()
            }
            
            if indicators.socioPoliticalInstability >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverInstabilityTitle
                    gameOverReason = Constants.GameEngine.gameOverInstabilityMessage
                    gameOverImage = Assets.Images.socioPoliticalEnd.swiftUIImage
                }
                applyGameOver()
            }
        }
    }
    
    func applyGameOver() {
        self.state = .gameOver
        // comentado finais especiais
        let character = currentEvent?.character
        if (Utils.isSpecialCharacter(character)) {
            let gameOver = Utils.switchMessageDependingOnCharacter(character)
            gameOverTitle = gameOver.title
            gameOverReason = gameOver.message
            let finalCharacter = "special final " + (character ?? "")
            gameOverImage = Utils.getImageByName(finalCharacter)
        }
        self.delegate?.gameStateChanged(to: .gameOver)
        SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "gameover", duration: 0.5)
    }

    func goToNextEvent() {
        checkForGameOver()
        if state == .consequence {
            state = .choosing
            
            if !eventsSequence.isEmpty {
                eventsSequence.removeFirst()
                
                if let nextEventID = eventsSequence.first {
                    if let nextEvent = events.first(where: { $0.id == nextEventID }) {
                        currentEvent = nextEvent
                        eventsPassedCount += 1
                        
                        if eventsPassedCount == Constants.GameEngine.eventsPerYear {
                            indicators.currentYear += 1
                            eventsPassedCount = 0
                        }
                    } else {
                        print("Next event not found in the events array.")
                        currentEvent = nil
                    }
                } else {
                    print("No more events in the sequence.")
                    currentEvent = nil
                }
            } else {
                print("Event sequence is empty.")
                currentEvent = nil
            }
        }
        if !gameEnded() {
            state = .choosing
        }
    }
    
    func chooseOption(option: Int) {
        if state == .choosing {
            if let event = currentEvent {
                let consequences = [event.consequence1, event.consequence2]
                indicators.applyConsequence(consequences[option-1])
                lastChosenOption = "choice\(option)"
                state = .consequence
                delegate?.gameStateChanged(to: .consequence)
            }
        }
    }

    func resetGame() {
        if state == .gameOver || state == .initializing {
            indicators = Indicators(audience: Constants.GameEngine.initialAudience,
                                    illBeing: Constants.GameEngine.initialIllBeing,
                                    socioPoliticalInstability: Constants.GameEngine.initialSocioPoliticalInstability,
                                    environmentalDegradation: Constants.GameEngine.initialEnvironmentalDegradation,
                                    currentYear: Constants.GameEngine.initialYear)
            let isReseting = state == .gameOver
            
            state = .choosing
            let shuffledEvents = events.shuffled()
            self.eventsSequence = shuffledEvents.map { $0.id }
            currentEvent = shuffledEvents.first
            eventsPassedCount = 0
            gameOverReason = ""
            SoundtrackAudioManager.shared.stopAllSoundEffects()
            if (isReseting) {
                SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "gameplay", duration: 0.5)
            }
        }
    }
}
