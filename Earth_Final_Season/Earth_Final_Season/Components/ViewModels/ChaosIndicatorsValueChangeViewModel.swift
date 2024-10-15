//
//  ChaosIndicatorsValueChangeViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation
import SwiftUI

@Observable
class ChaosIndicatorsValueChangeViewModel {
    var gameplayVM: GameplayViewModel
    var gameEngine: GameEngine
    let indicator: String
    
    init(gameplayVM: GameplayViewModel, gameEngine: GameEngine, indicator: String) {
        self.gameplayVM = gameplayVM
        self.gameEngine = gameEngine
        self.indicator = indicator
    }
    
    var scaleChange: CGFloat = 0
    var shouldShowIndicator: Bool = false
    var valueIsIncreasing: Bool = false
    var value: Int = 0
    
    func getIndicatorValue() {
        // stopped showing consequence: stop showing indicator and reset value
        if gameEngine.state != .consequence {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }

        if indicator == "illBeing" {
            if gameEngine.lastChosenOption == "choice1" &&
                gameEngine.currentEvent?.illBeing1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice1" &&
                        gameEngine.currentEvent?.illBeing1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            
            if gameEngine.lastChosenOption == "choice2" &&
                gameEngine.currentEvent?.illBeing2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice2" &&
                        gameEngine.currentEvent?.illBeing2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "environmentalDegradation" {
            if gameEngine.lastChosenOption == "choice1" &&
                gameEngine.currentEvent?.environmentalDegradation1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice1" &&
                        gameEngine.currentEvent?.environmentalDegradation1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }

            if gameEngine.lastChosenOption == "choice2" &&
                gameEngine.currentEvent?.environmentalDegradation2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice2" &&
                        gameEngine.currentEvent?.environmentalDegradation2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "sociopoliticalInstability" {
            if gameEngine.lastChosenOption == "choice1" &&
                gameEngine.currentEvent?.socioPoliticalInstability1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice1" &&
                        gameEngine.currentEvent?.socioPoliticalInstability1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            
            if gameEngine.lastChosenOption == "choice2" &&
                gameEngine.currentEvent?.socioPoliticalInstability2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameEngine.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
            else if gameEngine.lastChosenOption == "choice2" &&
                        gameEngine.currentEvent?.socioPoliticalInstability2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameEngine.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        scaleChange = 1
    }
}
