//
//  ChaosIndicatorsValueChangeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 07/10/24.
//

import SwiftUI

struct ChaosIndicatorsValueChangeView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State var scaleChange: CGFloat = 0
    @State var shouldShowIndicator: Bool = false
    @State var valueIsIncreasing: Bool = false
    @State var value: Int = 0
    
    let indicator: String

    var body: some View {
        HStack() {
            Image(systemName: valueIsIncreasing ? "arrowshape.up.fill" : "arrowshape.down.fill")
            Text(String(value))
        }
        .foregroundStyle(valueIsIncreasing ? .orange : .cyan)
        .opacity(shouldShowIndicator ? 1 : 0)
        .scaleEffect(scaleChange, anchor: .bottom)
        .onChange(of: gameplayVM.isShowingConsequence) {
            withAnimation(Animation.linear(duration: 1)) {
                getIndicatorValue()
            }
        }
    }

    private func getIndicatorValue() {
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
