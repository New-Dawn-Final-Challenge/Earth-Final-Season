//
//  Earth_Final_SeasonTest.swift
//  Earth_Final_SeasonTest
//
//  Created by Larissa Okabayashi on 07/10/24.
//

import XCTest
@testable import Earth_Final_Season

final class Earth_Final_SeasonTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadJSON() throws {
        let viewModel = GameplayViewModel()
        XCTAssertEqual(viewModel.events.count, 75, "The number of events should be 75. The number of events is \(viewModel.events.count)")
    }
    
    func testCheckForGameOver() {
        let viewModel = GameplayViewModel()

        // Test that the game ends when audience reaches 0
        viewModel.indicators.audience = 0
        viewModel.testableCheckForGameOver()
        XCTAssertTrue(viewModel.isGameOver, "Game should be over when audience reaches 0")

        // Test that the game ends when social instability reaches 20
        viewModel.indicators.socialInstability = 20
        viewModel.testableCheckForGameOver()
        XCTAssertTrue(viewModel.isGameOver, "Game should be over when social instability reaches 20")
        
        // Test that the game ends when environmental degradation reaches 20
        viewModel.indicators.environmentalDegradation = 20
        viewModel.testableCheckForGameOver()
        XCTAssertTrue(viewModel.isGameOver, "Game should be over when social instability reaches 20")
        
        // Test that the game ends when political instability reaches 20
        viewModel.indicators.politicalInstability = 20
        viewModel.testableCheckForGameOver()
        XCTAssertTrue(viewModel.isGameOver, "Game should be over when social instability reaches 20")
    }
    
    func testGameNotOverWhenIndicatorsWithinNormalRange() {
        let viewModel = GameplayViewModel()

        // Set all indicators to a normal range and check that the game does not end
        viewModel.indicators.audience = 1
        viewModel.indicators.socialInstability = 1
        viewModel.indicators.politicalInstability = 1
        viewModel.indicators.environmentalDegradation = 1
        viewModel.testableCheckForGameOver()
        
        XCTAssertFalse(viewModel.isGameOver, "Game should not be over when all indicators are within normal range")
    }


    // Test if the next event is loaded correctly
    func testGoToNextEventUpdatesCurrentEvent() {
        let viewModel = GameplayViewModel()
        
        // Create a mock event array with 3 events
        let mockEvents = [
            Event(id: "event1", character: "Character1", description: "Description1", choice1: "Choice1-1", choice2: "Choice1-2", socioPoliticalInstability1: 1, illBeing1: 1, environmentalDegradation1: 1, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 1, illBeing2: 1, environmentalDegradation2: 1, consequenceDescription2: "Consequence2", difficulty: .medium, tags: ["tag1"]),
            Event(id: "event2", character: "Character2", description: "Description2", choice1: "Choice2-1", choice2: "Choice2-2", socioPoliticalInstability1: 2, illBeing1: 2, environmentalDegradation1: 2, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 2, illBeing2: 2, environmentalDegradation2: 2, consequenceDescription2: "Consequence2", difficulty: .medium, tags: ["tag2"]),
            Event(id: "event3", character: "Character3", description: "Description3", choice1: "Choice3-1", choice2: "Choice3-2", socioPoliticalInstability1: 3, illBeing1: 3, environmentalDegradation1: 3, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 3, illBeing2: 3, environmentalDegradation2: 3, consequenceDescription2: "Consequence2", difficulty: .hard, tags: ["tag3"])
        ]
        
        // Set mock events
        viewModel.events = mockEvents
        if !viewModel.events.isEmpty {
            viewModel.eventsSequence = viewModel.events.map { $0.id }
            viewModel.currentEvent = viewModel.events.first
        } else {
            viewModel.currentEvent = nil
            print("No events loaded.")
        }
        
        viewModel.testableGoToNextEvent()
        
        // Check if the first event is correctly set
        XCTAssertEqual(viewModel.currentEvent?.id, "event1", "The first event should be event1")
        
        // Move to the next event
        viewModel.testableGoToNextEvent()
        
        // Check if the current event is now "event2"
        XCTAssertEqual(viewModel.currentEvent?.id, "event2", "The current event should now be event2")
        
        // Move to the next event again
        viewModel.testableGoToNextEvent()
        
        // Check if the current event is now "event3"
        XCTAssertEqual(viewModel.currentEvent?.id, "event3", "The current event should now be event3")
    }

    // Test year increment after two events
    func testGoToNextEventIncrementsYear() {
        // Create a mock event array with 2 events
        let mockEvents = [
            Event(id: "event1", character: "Character1", description: "Description1", choice1: "Choice1-1", choice2: "Choice1-2", socioPoliticalInstability1: 1, illBeing1: 1, environmentalDegradation1: 1, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 1, illBeing2: 1, environmentalDegradation2: 1, consequenceDescription2: "Consequence2", difficulty: .medium, tags: ["tag1"]),
            Event(id: "event2", character: "Character2", description: "Description2", choice1: "Choice2-1", choice2: "Choice2-2", socioPoliticalInstability1: 2, illBeing1: 2, environmentalDegradation1: 2, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 2, illBeing2: 2, environmentalDegradation2: 2, consequenceDescription2: "Consequence2", difficulty: .medium, tags: ["tag2"])
        ]
        
        // Create an instance of GameplayViewModel
        let viewModel = GameplayViewModel()
        
        // Set mock events
        viewModel.events = mockEvents
        if !viewModel.events.isEmpty {
            let shuffledEvents = viewModel.events.shuffled()
            viewModel.eventsSequence = shuffledEvents.map { $0.id }
            viewModel.currentEvent = shuffledEvents.first
        } else {
            viewModel.currentEvent = nil
            print("No events loaded.")
        }
        // Simulate two events passing
        viewModel.testableGoToNextEvent() // Move to event2
        viewModel.testableGoToNextEvent() // All events passed
        
        // Check if the year has been incremented after 2 events
        XCTAssertEqual(viewModel.indicators.currentYear, 1, "The year should increment after 2 events")
    }

    // Test if no events are left in the sequence
    func testGoToNextEventHandlesEndOfSequence() {
        // Create a mock event array with 1 event
        let mockEvents = [
            Event(id: "event1", character: "Character1", description: "Description1", choice1: "Choice1-1", choice2: "Choice1-2", socioPoliticalInstability1: 1, illBeing1: 1, environmentalDegradation1: 1, consequenceDescription1: "Consequence1", socioPoliticalInstability2: 1, illBeing2: 1, environmentalDegradation2: 1, consequenceDescription2: "Consequence2", difficulty: .medium, tags: ["tag1"])
        ]
        
        // Create an instance of GameplayViewModel
        let viewModel = GameplayViewModel()
        
        // Set mock events
        viewModel.events = mockEvents
        if !viewModel.events.isEmpty {
            let shuffledEvents = viewModel.events.shuffled()
            viewModel.eventsSequence = shuffledEvents.map { $0.id }
            viewModel.currentEvent = shuffledEvents.first
        } else {
            viewModel.currentEvent = nil
            print("No events loaded.")
        }
        
        // Move to the only event
        viewModel.testableGoToNextEvent()
        
        // Move past the last event
        viewModel.testableGoToNextEvent()
        
        // Check if there are no more events left
        XCTAssertNil(viewModel.currentEvent, "There should be no current event when the sequence is empty")
    }

}
