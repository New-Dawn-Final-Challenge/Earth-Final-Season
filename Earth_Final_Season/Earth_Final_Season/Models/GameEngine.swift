//
//  GameEngine.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 11/10/24.
//

import Foundation
import SwiftUI

@Observable
class GameEngine {
    var countdown = 6
    var timer: Timer?
    var gameOverReason = ""
    var lastChosenOption = "choice1"
    var events = [Event]()
    var currentEvent: Event?
    var indicators = Indicators(audience: 5,
                                illBeing: 6,
                                socioPoliticalInstability: 6,
                                environmentalDegradation: 6,
                                currentYear: 0)  // Initial Indicators
    
    private var eventsSequence: [String] = []
    private var eventsPassedCount = 0
    
    var state: states = .initializing

    init() {
        if state == .initializing {
            events = loadAndReturnEvents()

            if !events.isEmpty {
                let shuffledEvents = events.shuffled()
                self.eventsSequence = shuffledEvents.map { $0.id }
                currentEvent = shuffledEvents.first
            } else {
                currentEvent = nil
                print("No events loaded.")
            }
            state = .choosing
        }
    }
    
    private func checkForGameOver() {
        if state == .consequence {
            if indicators.audience <= 3 {
                gameOverReason = "audience"
                state = .gameOver
            }
            if indicators.environmentalDegradation >= 12 {
                gameOverReason = "environmentalDegradation"
                state = .gameOver
            }
            if indicators.illBeing >= 12 {
                gameOverReason = "illBeing"
                state = .gameOver
            }
            if indicators.socioPoliticalInstability >= 12 {
                gameOverReason = "socioPoliticalInstability"
                state = .gameOver
            }
        }
    }

    private func goToNextEvent() {
        checkForGameOver()
        if state == .consequence {
            state = .choosing
            
            if !eventsSequence.isEmpty {
                eventsSequence.removeFirst()
                
                if let nextEventID = eventsSequence.first {
                    if let nextEvent = events.first(where: { $0.id == nextEventID }) {
                        currentEvent = nextEvent
                        eventsPassedCount += 1
                        
                        if eventsPassedCount == 2 {
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
    }
    
    func chooseOption1() {
        if state == .choosing {
            if let event = currentEvent {
                indicators.applyConsequence(event.consequence1)
                lastChosenOption = "choice1"
                state = .consequence

                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if self.countdown > 0 {
                        self.countdown -= 1
                    } else {
                        self.timer?.invalidate()
                        self.timer = nil
                        self.countdown = 6
                        
                        self.goToNextEvent()
//                        self.isShowingConsequence = false
                    }
                }
            }
        }
    }

    func chooseOption2() {
        if state == .choosing {
            if let event = currentEvent {
                indicators.applyConsequence(event.consequence2)
                lastChosenOption = "choice2"
                state = .consequence
                
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if self.countdown > 0 {
                        self.countdown -= 1
                    } else {
                        self.timer?.invalidate()
                        self.timer = nil
                        self.countdown = 6
                        
                        self.goToNextEvent()
//                        self.isShowingConsequence = false
                    }
                }
            }
        }
    }

    func resetGame() {
        if state == .gameOver{
            indicators = Indicators(audience: 5, illBeing: 6, socioPoliticalInstability: 6, environmentalDegradation: 6, currentYear: 0)
            state = .initializing
            let shuffledEvents = events.shuffled()
            self.eventsSequence = shuffledEvents.map { $0.id }
            currentEvent = shuffledEvents.first
            eventsPassedCount = 0
        }
    }
}
