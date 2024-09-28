//
//  GameplayModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 25/09/24.
//

import Foundation

struct Event: EventService, Codable {
    let id: UUID
    let character: String
    let image: String
    let description: String
    let choice1: String
    let choice2: String
    let audience1: Int
    let socialInstability1: Int
    let politicalInstability1: Int
    let environmentalDegradation1: Int
    let audience2: Int
    let socialInstability2: Int
    let politicalInstability2: Int
    let environmentalDegradation2: Int
    let difficulty: Difficulty
    let tags: [String]

    var consequence1: Consequence {
        return Consequence(socialInstability: socialInstability1, politicalInstability: politicalInstability1, environmentalDegradation: environmentalDegradation1, description: description)
    }
    var consequence2: Consequence {
        return Consequence(socialInstability: socialInstability2, politicalInstability: politicalInstability2, environmentalDegradation: environmentalDegradation2, description: description)
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
        
        // Update the audience to be the mean of the other indicators multiplied by 10
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
