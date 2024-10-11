//
//  ChaosIndicatorsValueChangeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 07/10/24.
//

import SwiftUI

struct ChaosIndicatorsValueChangeView: View {
    @State var scaleChange: CGFloat = 0
    @State var shouldShowIndicator: Bool = false
    @State var valueIsIncreasing: Bool = false
    @State var value: Int = 0
    
    @Binding var engine: GameEngine
    @Binding var viewModel: GameplayViewModel
    let indicator: String
    

    var body: some View {
        HStack() {
            Image(systemName: valueIsIncreasing ? "arrowshape.up.fill" : "arrowshape.down.fill")
            Text(String(value))
        }
        .foregroundStyle(valueIsIncreasing ? .orange : .cyan)
        .opacity(shouldShowIndicator ? 1 : 0)
        .scaleEffect(scaleChange, anchor: .bottom)
        .onChange(of: engine.state == .consequence) {
            withAnimation(Animation.linear(duration: 1)) {
                getIndicatorValue()
            }
        }
    }

    private func getIndicatorValue() {
        // stopped showing consequence: stop showing indicator and reset value
        if !(engine.state == .consequence) {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }

        if indicator == "illBeing" {
            if engine.lastChosenOption == "choice1" &&
                engine.currentEvent?.illBeing1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice1" &&
                        engine.currentEvent?.illBeing1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            
            if engine.lastChosenOption == "choice2" &&
                engine.currentEvent?.illBeing2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice2" &&
                        engine.currentEvent?.illBeing2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "environmentalDegradation" {
            if engine.lastChosenOption == "choice1" &&
                engine.currentEvent?.environmentalDegradation1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice1" &&
                        engine.currentEvent?.environmentalDegradation1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }

            if engine.lastChosenOption == "choice2" &&
                engine.currentEvent?.environmentalDegradation2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice2" &&
                        engine.currentEvent?.environmentalDegradation2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "sociopoliticalInstability" {
            if engine.lastChosenOption == "choice1" &&
                engine.currentEvent?.socioPoliticalInstability1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice1" &&
                        engine.currentEvent?.socioPoliticalInstability1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            
            if engine.lastChosenOption == "choice2" &&
                engine.currentEvent?.socioPoliticalInstability2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = engine.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
            else if engine.lastChosenOption == "choice2" &&
                        engine.currentEvent?.socioPoliticalInstability2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = engine.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        scaleChange = 1
    }
}

