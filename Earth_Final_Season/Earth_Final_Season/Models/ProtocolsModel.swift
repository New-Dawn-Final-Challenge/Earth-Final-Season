//
//  ContentModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation

// Event Protocol
protocol EventService {
//    var id: UUID { get }
    var character: String { get }
//    var image: String { get }
    var description: String { get }
    var choice1: String { get }
    var choice2: String { get }
//    var audience1: Int { get }
    var socioPoliticalInstability1: Int { get }
    var illBeing1: Int { get }
    var environmentalDegradation1: Int { get }
//    var audience2: Int { get }
    var socioPoliticalInstability2: Int { get }
    var illBeing2: Int { get }
    var environmentalDegradation2: Int { get }
    var difficulty: Difficulty { get }
    var tags: [String] { get }
}

// Consequence Protocol
protocol ConsequenceService {
    var socialInstability: Int { get }
    var politicalInstability: Int { get }
    var environmentalDegradation: Int { get }
    var description: String { get }
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
