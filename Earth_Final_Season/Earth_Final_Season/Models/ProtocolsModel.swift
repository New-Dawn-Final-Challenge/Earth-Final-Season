//
//  ContentModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation

// Event Protocol
protocol EventService {
    var character: String { get set }
    var description: String { get set }
    var choice1: String { get set }
    var choice2: String { get set }
    var socioPoliticalInstability1: Int { get set }
    var illBeing1: Int { get set }
    var environmentalDegradation1: Int { get set }
    var socioPoliticalInstability2: Int { get set }
    var illBeing2: Int { get set }
    var environmentalDegradation2: Int { get set }
    var consequenceDescription2: String { get set }
    var difficulty: Difficulty { get set }
    var tags: [String] { get set }
}

// Consequence Protocol
protocol ConsequenceService {
    var socialInstability: Int { get set }
    var politicalInstability: Int { get set }
    var environmentalDegradation: Int { get set }
    var description: String { get set }
}

// Indicator Protocol
protocol IndicatorService {
    var audience: Int { get set }
    var socialInstability: Int { get set }
    var politicalInstability: Int { get set }
    var environmentalDegradation: Int { get set }
    var currentYear: Int { get set }
    mutating func applyConsequence(_ consequence: Consequence)
}
