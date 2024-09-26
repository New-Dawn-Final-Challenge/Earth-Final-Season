//
//  GameplayViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation

class GameplayViewModel: ObservableObject {
    @Published var currentEvent: Event?
    @Published var indicators = Indicators(audience: 5, socialInstability: 5, politicalInstability: 5, environmentalDegradation: 5, currentYear: 0)  // Initial Indicators
    
    private var events: [UUID: Event]
    private var eventsSequence: [UUID]

    init(events: [Event]) {
        let shuffledEvents = events.shuffled()
        self.events = Dictionary(uniqueKeysWithValues: shuffledEvents.map { ($0.id, $0) })
        self.eventsSequence = shuffledEvents.map { $0.id }
        currentEvent = shuffledEvents.first
    }

    private func goToNextEvent() {
        if !eventsSequence.isEmpty {
            eventsSequence.removeFirst()
            
            if let nextEventID = eventsSequence.first {
                currentEvent = events[nextEventID]
            } else {
                currentEvent = nil
            }
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
