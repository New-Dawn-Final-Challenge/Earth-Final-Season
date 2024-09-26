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
        // Load events and ensure UUIDs are correctly initialized
        events = loadAndReturnEvents()
        
        // Print the UUIDs of all the events for debugging
        for event in events {
            print("Event ID: \(event.id)")
        }

        // Ensure the events are shuffled and the sequence is generated from these exact events
        if !events.isEmpty {
            let shuffledEvents = events.shuffled()
            
            // The sequence should now refer to the same shuffled events
            self.eventsSequence = shuffledEvents.map { $0.id }
            
            // Set the current event to the first event in the shuffled sequence
            currentEvent = shuffledEvents.first
        } else {
            currentEvent = nil
            print("No events loaded.")
        }
    }



    private func goToNextEvent() {
        if !eventsSequence.isEmpty {
            // Remove the first event in the sequence
            eventsSequence.removeFirst()

            // Debugging prints to check what's happening
            print("Remaining event sequence: \(eventsSequence)")
            
            // Get the next event ID and find the event in the events array
            if let nextEventID = eventsSequence.first {
                if let nextEvent = events.first(where: { $0.id == nextEventID }) {
                    currentEvent = nextEvent
                    print("Next event found: \(nextEvent.description)")
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
