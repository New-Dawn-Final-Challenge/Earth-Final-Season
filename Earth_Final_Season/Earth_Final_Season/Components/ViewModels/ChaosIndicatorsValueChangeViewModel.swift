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
        if  gameplayVM.currentState != .consequence {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }
        
        let illBeing = [gameEngine.currentEvent?.illBeing1, gameEngine.currentEvent?.illBeing2]
        let environmentalDegradation = [gameEngine.currentEvent?.environmentalDegradation1,
                                        gameEngine.currentEvent?.environmentalDegradation2]
        let socioPoliticalInstability = [gameEngine.currentEvent?.socioPoliticalInstability1,
                                          gameEngine.currentEvent?.socioPoliticalInstability2]
        
        var optionToget = 0
        switch gameEngine.lastChosenOption {
            case "choice1":
            optionToget = 0
            case "choice2":
            optionToget = 1
        default :    break
        }
        
        valueIsIncreasing = false
        if indicator == "illBeing" {
            value = illBeing[optionToget] ?? 0
        }
        if indicator == "environmentalDegradation" {
            value = environmentalDegradation[optionToget] ?? 0
        }
        if indicator == "sociopoliticalInstability" {
            value = socioPoliticalInstability[optionToget] ?? 0
        }
        
        if value > 0 {
            valueIsIncreasing = true
        }
        
        shouldShowIndicator = true
        
        if value == 0 {
            shouldShowIndicator = false
        }
        
        scaleChange = 1
    }
}
