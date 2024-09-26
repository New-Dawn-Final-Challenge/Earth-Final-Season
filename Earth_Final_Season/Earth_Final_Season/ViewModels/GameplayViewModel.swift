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
    @Published var indicators = Indicators(audience: 5, socialInstability: 5, politicalInstability: 5, environmentalDegradation: 5, currentYear: 0)  // Initial Indicators
    
    private var eventsSequence: [UUID] = []
    
    init() {
        events = loadAndReturnEvents()
        // Shuffle the events and map their IDs into the sequence
        if !events.isEmpty {
           let shuffledEvents = events.shuffled()
            self.eventsSequence = shuffledEvents.map { $0.uuid }
           currentEvent = shuffledEvents.first
        } else {
           // Handle case when no events are loaded
           currentEvent = nil
           print("No events loaded.")
        }
    }

    private func goToNextEvent() {
        // Remove the first event in the sequence
        if !eventsSequence.isEmpty {
            eventsSequence.removeFirst()
        }
        
        // Get the next event ID and find the event in the events array
        if let nextEventID = eventsSequence.first {
            currentEvent = events.first(where: { $0.uuid == nextEventID })
        } else {
            // No more events left
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
