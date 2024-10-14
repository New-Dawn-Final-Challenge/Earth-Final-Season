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
    let indicator: String
    
    init(gameplayVM: GameplayViewModel, indicator: String) {
        self.gameplayVM = gameplayVM
        self.indicator = indicator
    }
    
    var scaleChange: CGFloat = 0
    var shouldShowIndicator: Bool = false
    var valueIsIncreasing: Bool = false
    var value: Int = 0
    
    func getIndicatorValue() {
        // stopped showing consequence: stop showing indicator and reset value
        if gameplayVM.isShowingConsequence == false {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }

        if indicator == "illBeing" {
            if gameplayVM.lastChosenOption == "choice1" &&
                gameplayVM.currentEvent?.illBeing1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice1" &&
                    gameplayVM.currentEvent?.illBeing1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            
            if gameplayVM.lastChosenOption == "choice2" &&
                gameplayVM.currentEvent?.illBeing2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice2" &&
                    gameplayVM.currentEvent?.illBeing2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "environmentalDegradation" {
            if gameplayVM.lastChosenOption == "choice1" &&
                gameplayVM.currentEvent?.environmentalDegradation1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice1" &&
                    gameplayVM.currentEvent?.environmentalDegradation1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }

            if gameplayVM.lastChosenOption == "choice2" &&
                gameplayVM.currentEvent?.environmentalDegradation2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice2" &&
                    gameplayVM.currentEvent?.environmentalDegradation2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "sociopoliticalInstability" {
            if gameplayVM.lastChosenOption == "choice1" &&
                gameplayVM.currentEvent?.socioPoliticalInstability1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice1" &&
                    gameplayVM.currentEvent?.socioPoliticalInstability1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            
            if gameplayVM.lastChosenOption == "choice2" &&
                gameplayVM.currentEvent?.socioPoliticalInstability2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = gameplayVM.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
            else if gameplayVM.lastChosenOption == "choice2" &&
                    gameplayVM.currentEvent?.socioPoliticalInstability2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = gameplayVM.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        scaleChange = 1
    }
}
