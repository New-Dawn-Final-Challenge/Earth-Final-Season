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
        return Consequence(socialInstability: illBeing1, politicalInstability: socioPoliticalInstability1, environmentalDegradation: environmentalDegradation1, description: description)
    }
    var consequence2: Consequence {
        return Consequence(socialInstability: illBeing1, politicalInstability: socioPoliticalInstability2, environmentalDegradation: environmentalDegradation2, description: description)
    }
}

struct Consequence: ConsequenceService, Codable {
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
        // Update indicators with new consequences
        socialInstability += consequence.socialInstability
        politicalInstability += consequence.politicalInstability
        environmentalDegradation += consequence.environmentalDegradation
        
        // Print updated values
        printUpdatedValues()
        
        // Update the audience to be the mean of the other indicators
        updateAudience()
    }
    
    mutating func updateAudience() {
        let total = socialInstability + politicalInstability + environmentalDegradation
        let count = 3
        audience = (total / count)
        
        // Print updated audience value
        print("Updated Audience: \(audience)")
    }
    
    // Function to print updated indicator values
    private func printUpdatedValues() {
        print("Updated Social Instability: \(socialInstability)")
        print("Updated Political Instability: \(politicalInstability)")
        print("Updated Environmental Degradation: \(environmentalDegradation)")
    }
}
