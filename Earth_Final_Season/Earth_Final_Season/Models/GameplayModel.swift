//
//  GameplayModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 25/09/24.
//

import Foundation

struct Event: EventService, Codable {
    let id: String
    var character: String
    var description: String
    var choice1: String
    var choice2: String
    var socioPoliticalInstability1: Int
    var illBeing1: Int
    var environmentalDegradation1: Int
    var consequenceDescription1: String
    var socioPoliticalInstability2: Int
    var illBeing2: Int
    var environmentalDegradation2: Int
    var consequenceDescription2: String
    var difficulty: Difficulty
    var tags: [String]

    var consequence1: Consequence {
        return Consequence(illBeing: illBeing1, socioPoliticalInstability: socioPoliticalInstability1, environmentalDegradation: environmentalDegradation1, description: description)
    }
    var consequence2: Consequence {
        return Consequence(illBeing: illBeing2, socioPoliticalInstability: socioPoliticalInstability2, environmentalDegradation: environmentalDegradation2, description: description)
    }
}

struct Consequence: ConsequenceService, Codable {
    var illBeing: Int
    var socioPoliticalInstability: Int
    var environmentalDegradation: Int
    var description: String
}

struct Indicators: IndicatorService {
    var audience: Double
    var illBeing: Int
    var socioPoliticalInstability: Int
    var environmentalDegradation: Int
    var currentYear: Int
    
    mutating func applyConsequence(_ consequence: Consequence) {
        // Update indicators with new consequences
        illBeing += consequence.illBeing
        socioPoliticalInstability += consequence.socioPoliticalInstability
        environmentalDegradation += consequence.environmentalDegradation
        
        // Print updated values
        printUpdatedValues()
        
        // Update the audience to be the mean of the other indicators
        updateAudience()
    }
    
    mutating func updateAudience() {
        let total = illBeing + socioPoliticalInstability + environmentalDegradation
        let count = 3
        audience = Double((total / count))
        
        // Print updated audience value
        print("Updated Audience: \(audience)")
    }
    
    // Function to print updated indicator values
    private func printUpdatedValues() {
        print("Updated Ill-Being: \(illBeing)")
        print("Updated Sociopolitical Instability: \(socioPoliticalInstability)")
        print("Updated Environmental Degradation: \(environmentalDegradation)")
    }
}
