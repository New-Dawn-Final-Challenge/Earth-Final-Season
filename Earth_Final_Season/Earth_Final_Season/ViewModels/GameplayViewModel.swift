//
//  GameplayViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation

class GameplayViewModel: ObservableObject {
    @Published var events = [Event]()
    @Published var currentEvent: Event?
    @Published var indicators = Indicators(audience: 100, socialInstability: 10, politicalInstability: 10, environmentalDegradation: 10, currentYear: 0)  // Initial Indicators
    
    private var eventsSequence: [UUID] = []
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

    private func goToNextEvent() {
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
            indicators.applyConsequence(event.consequence1)
            goToNextEvent()
        }
    }
    
    func chooseOption2() {
        if let event = currentEvent {
            indicators.applyConsequence(event.consequence2)
            goToNextEvent()
        }
    }
}
