//
//  GameplayViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation
import SwiftUI

@Observable
class GameplayViewModel {
    var isGameOver = false
    var isShowingConsequence = false
    var lastChosenOption = "choice1"
    var currentPosition: CGSize = .zero
    var mainScreenShadowRadius = 0
    var option1ShadowRadius = 0
    var option2ShadowRadius = 0
    var events = [Event]()
    var currentEvent: Event?
    var indicators = Indicators(audience: 10, socialInstability: 10, politicalInstability: 10, environmentalDegradation: 10, currentYear: 0)  // Initial Indicators
    
    private var eventsSequence: [String] = []
    private var eventsPassedCount = 0

    init() {
        events = loadAndReturnEvents()

        if !events.isEmpty {
            let shuffledEvents = events.shuffled()
            self.eventsSequence = shuffledEvents.map { $0.id }
            currentEvent = shuffledEvents.first
        } else {
            currentEvent = nil
            print("No events loaded.")
        }
    }
    
    private func checkForGameOver() {
        if indicators.audience <= 0 || indicators.audience >= 20 ||
           indicators.socialInstability <= 0 || indicators.socialInstability >= 20 ||
           indicators.politicalInstability <= 0 || indicators.politicalInstability >= 20 ||
           indicators.environmentalDegradation <= 0 || indicators.environmentalDegradation >= 20 {
            isGameOver = true
        }
    }

    private func goToNextEvent() {
        checkForGameOver()
        
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
    
    func chooseOption1() {
        if let event = currentEvent {
//            event.applyConsequence(consequence: event.consequenceDescription1)
            indicators.applyConsequence(event.consequence1)
            lastChosenOption = "choice1"
            
            withAnimation {
                self.isShowingConsequence = true
            }
            
            // show next event after 6 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                withAnimation {
                    self.goToNextEvent()
                    self.isShowingConsequence = false
                }
            }
        }
    }
    
    func chooseOption2() {
        if let event = currentEvent {
            indicators.applyConsequence(event.consequence2)
            lastChosenOption = "choice2"
        
            withAnimation {
                self.isShowingConsequence = true
            }
            
            
            
            // show next event after 6 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                withAnimation {
                    self.goToNextEvent()
                    self.isShowingConsequence = false
                }
            }
        }
    }
    
    func resetGame() {
        indicators = Indicators(audience: 10, socialInstability: 10, politicalInstability: 10, environmentalDegradation: 10, currentYear: 0)
        isGameOver = false
        events = loadAndReturnEvents()
        let shuffledEvents = events.shuffled()
        self.eventsSequence = shuffledEvents.map { $0.id }
        currentEvent = shuffledEvents.first
        eventsPassedCount = 0
    }
}
