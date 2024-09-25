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
        self.events = Dictionary(uniqueKeysWithValues: events.map { ($0.id, $0) })
        self.eventsSequence = events.map { $0.id }
        currentEvent = events.first
    }
    
    func swipeRight() {
        if let event = currentEvent {
            indicators.applyConsequence(event.consequence1)
        }
    }
    
    func swipeLeft() {
        if let event = currentEvent {
            indicators.applyConsequence(event.consequence2)
        }
    }
}
