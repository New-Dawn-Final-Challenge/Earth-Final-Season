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
                                currentYear: Constants.GameEngine.initialYear)
    var unlockedCharacters: [String] = ["ultra new age environmentalist",
                                        "sensationalist tv host",
                                        "questionable religious leader",
                                        "evil researcher"]
    
    private var isPortuguese: Bool
    private var eventsSequence: [String] = []
    private var eventsPassedCount = 0
    var state: States = .initializing
    
    var allEvents: [Event] = []  // Initialize it as an empty array first
    
    init(delegate: GameplayViewModel) {
        self.delegate = delegate
        self.isPortuguese = delegate.isPortuguese
        
        // Now initialize allEvents after isPortuguese is set
        self.allEvents = loadAndReturnEvents(isPortuguese: self.isPortuguese)
        
        loadUnlockedCharacters()
        events = filterUnlockedEvents(from: allEvents)
        resetGame()
    }
    
    func filterUnlockedEvents(from allEvents: [Event]) -> [Event] {
        return allEvents.filter { event in
            return unlockedCharacters.contains(event.character.lowercased())
        }
    }

    func saveUnlockedCharacters() {
        UserDefaults.standard.set(unlockedCharacters, forKey: "unlockedCharacters")
    }

    func loadUnlockedCharacters() {
        if let savedCharacters = UserDefaults.standard.array(forKey: "unlockedCharacters") as? [String] {
            unlockedCharacters = savedCharacters
        } else {
            unlockedCharacters = ["ultra new age environmentalist",
                                   "sensationalist tv host",
                                   "questionable religious leader",
                                   "evil researcher"]
        }
    }
    
    func gameEnded() -> Bool {
        return indicators.audience <= Constants.GameEngine.minAudienceThreshold ||
               indicators.environmentalDegradation >= Constants.GameEngine.maxIndicatorThreshold ||
               indicators.illBeing >= Constants.GameEngine.maxIndicatorThreshold ||
               indicators.socioPoliticalInstability >= Constants.GameEngine.maxIndicatorThreshold
    }
    
    func checkForGameOver(isPortuguese: Bool) {
        if state == .consequence {
            if indicators.audience <= Constants.GameEngine.minAudienceThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverAudienceTitle(isPortuguese: isPortuguese)
                    gameOverReason = Constants.GameEngine.gameOverAudienceMessage(isPortuguese: isPortuguese)
                    gameOverImage = Assets.Images.audienceEnd.swiftUIImage
                }
                applyGameOver(isPortuguese: isPortuguese)
            }
            
            if indicators.environmentalDegradation >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverEnvironmentTitle(isPortuguese: isPortuguese)
                    gameOverReason = Constants.GameEngine.gameOverEnvironmentMessage(isPortuguese: isPortuguese)
                    gameOverImage = Assets.Images.environmentalEnd.swiftUIImage
                }
                applyGameOver(isPortuguese: isPortuguese)
            }
            
            if indicators.illBeing >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverIllBeingTitle(isPortuguese: isPortuguese)
                    gameOverReason = Constants.GameEngine.gameOverIllBeingMessage(isPortuguese: isPortuguese)
                    gameOverImage = Assets.Images.illBeingEnd.swiftUIImage
                }
                applyGameOver(isPortuguese: isPortuguese)
            }
            
            if indicators.socioPoliticalInstability >= Constants.GameEngine.maxIndicatorThreshold {
                if gameOverReason.isEmpty {
                    gameOverTitle = Constants.GameEngine.gameOverInstabilityTitle(isPortuguese: isPortuguese)
                    gameOverReason = Constants.GameEngine.gameOverInstabilityMessage(isPortuguese: isPortuguese)
                    gameOverImage = Assets.Images.socioPoliticalEnd.swiftUIImage
                }
                applyGameOver(isPortuguese: isPortuguese)
            }
        }
    }
    
    func applyGameOver(isPortuguese: Bool) {
        self.state = .gameOver
        let character = currentEvent?.character
        if Utils.isSpecialCharacter(character) {
            let gameOver = Utils.switchMessageDependindOnCharacter(character, isPortuguese: isPortuguese)
            gameOverTitle = gameOver.title
            gameOverReason = gameOver.message
            let finalCharacter = "special final " + (character ?? "")
            gameOverImage = Utils.getImageByName(finalCharacter)
        }
        self.delegate?.gameStateChanged(to: .gameOver)
        SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "gameover", duration: 0.5)
    }

    func goToNextEvent(isPortuguese: Bool) {
        checkForGameOver(isPortuguese: isPortuguese)
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
                    // Reshuffle the events and restart the sequence
                    let shuffledEvents = filterUnlockedEvents(from: allEvents).shuffled()
                    self.eventsSequence = shuffledEvents.map { $0.id }
                    currentEvent = shuffledEvents.first
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
            
            let shuffledEvents = filterUnlockedEvents(from: allEvents).shuffled()
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
