//
//  ContentModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation

// Event Protocol
protocol EventService {
    var id: UUID { get }
    var character: String { get }
    var description: String { get }
    var choice1: String { get }
    var choice2: String { get }
    var consequence1: ConsequenceService { get }
    var consequence2: ConsequenceService { get }
    var difficulty: Difficulty { get }
    var tags: [Tags] { get }
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
    func applyConsequence()
}
