//
//  GameplayModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 25/09/24.
//

import Foundation

struct Event: EventService {
    let id: UUID
    let character: String
    let description: String
    let choice1: String
    let choice2: String
    let consequence1: Consequence
    let consequence2: Consequence
    let difficulty: Difficulty
    let tags: [Tags]
}

struct Consequence: ConsequenceService {
    var socialInstability: Int
    var politicalInstability: Int
    var environmentalDegradation: Int
    var description: String
}

struct Indicators: IndicatorService {
    var audience: Int
    var socialInstability: Int
    var politicalInstability: Int
    var environmentalDegradation: Int
    var currentYear: Int
    
    mutating func applyConsequence(_ consequence: Consequence) {
        socialInstability += consequence.socialInstability
        politicalInstability += consequence.politicalInstability
        environmentalDegradation += consequence.environmentalDegradation
    }
}
