//
//  GameplayViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation
import SwiftUI

@Observable @MainActor
class GameplayViewModel {
    var environmentalDegradationDecreaseShadowRadius = 0
    var environmentalDegradationIncreaseShadowRadius = 0
    var environmentalDegradationShadowRadius = 0
    var illBeingDecreaseShadowRadius = 0
    var illBeingIncreaseShadowRadius = 0
    var illBeingShadowRadius = 0
    var isGameOver = false
    var isShowingConsequence = false
    var lastChosenOption = "choice1"
    var currentPosition: CGSize = .zero
    var mainScreenShadowRadius = 0
    var option1ShadowRadius = 0
    var option2ShadowRadius = 0
    var sociopoliticalInstabilityDecreaseShadowRadius = 0
    var sociopoliticalInstabilityIncreaseShadowRadius = 0
    var sociopoliticalInstabilityShadowRadius = 0
    var events = [Event]()
    var currentEvent: Event?
    var indicators = Indicators(audience: 5,
                                illBeing: 6,
                                socioPoliticalInstability: 6,
                                environmentalDegradation: 6,
                                currentYear: 0)  // Initial Indicators
    
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
        if indicators.audience <= 3 ||
           indicators.illBeing <= 0 || indicators.illBeing >= 12 ||
           indicators.socioPoliticalInstability <= 0 || indicators.socioPoliticalInstability >= 12 ||
           indicators.environmentalDegradation <= 0 || indicators.environmentalDegradation >= 12 {
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
            self.isShowingConsequence = true
            
            withAnimation(Animation.linear(duration: 1)) {
                animateIndicatorsChange()
            }
            // Show next event after 6 seconds
            Task { @MainActor in
                try await Task.sleep(nanoseconds: 6_000_000_000)
                self.goToNextEvent()
                self.isShowingConsequence = false
                
                withAnimation {
                    self.sociopoliticalInstabilityDecreaseShadowRadius = 0
                    self.sociopoliticalInstabilityIncreaseShadowRadius = 0
                    self.illBeingDecreaseShadowRadius = 0
                    self.illBeingIncreaseShadowRadius = 0
                    self.environmentalDegradationDecreaseShadowRadius = 0
                    self.environmentalDegradationIncreaseShadowRadius = 0
                }
            }
        }
    }
    
    func chooseOption2() {
        if let event = currentEvent {
            indicators.applyConsequence(event.consequence2)
            lastChosenOption = "choice2"
            self.isShowingConsequence = true
            
            withAnimation(Animation.linear(duration: 1)) {
                animateIndicatorsChange()
            }

            // Show next event after 6 seconds
            Task { @MainActor in
                try await Task.sleep(nanoseconds: 6_000_000_000)
                self.goToNextEvent()
                self.isShowingConsequence = false
                
                withAnimation {
                    self.sociopoliticalInstabilityDecreaseShadowRadius = 0
                    self.sociopoliticalInstabilityIncreaseShadowRadius = 0
                    self.illBeingDecreaseShadowRadius = 0
                    self.illBeingIncreaseShadowRadius = 0
                    self.environmentalDegradationDecreaseShadowRadius = 0
                    self.environmentalDegradationIncreaseShadowRadius = 0
                }
            }
        }
    }
    
    func animateIndicatorsChange() {
        if let event = currentEvent {
            if lastChosenOption == "choice1" {
                if event.environmentalDegradation1 > 0 {
                    environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation1 < 0 {
                    environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing1 > 0 {
                    illBeingIncreaseShadowRadius = 7
                } else if event.illBeing1 < 0 {
                    illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability1 > 0 {
                    sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability1 < 0 {
                    sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
            
            else if lastChosenOption == "choice2" {
                if event.environmentalDegradation2 > 0 {
                    environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation2 < 0 {
                    environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing2 > 0 {
                    illBeingIncreaseShadowRadius = 7
                } else if event.illBeing2 < 0 {
                    illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability2 > 0 {
                    sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability2 < 0 {
                    sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
        }
    }
    
    func resetGame() {
        indicators = Indicators(audience: 5, illBeing: 6, socioPoliticalInstability: 6, environmentalDegradation: 6, currentYear: 0)
        isGameOver = false
        events = loadAndReturnEvents()
        let shuffledEvents = events.shuffled()
        self.eventsSequence = shuffledEvents.map { $0.id }
        currentEvent = shuffledEvents.first
        eventsPassedCount = 0
    }
}
