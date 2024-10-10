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
        .onChange(of: viewModel.isShowingConsequence) {
            withAnimation(Animation.linear(duration: 1)) {
                getIndicatorValue()
            }
        }
    }

    private func getIndicatorValue() {
        // stopped showing consequence: stop showing indicator and reset value
        if viewModel.isShowingConsequence == false {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }

        if indicator == "illBeing" {
            if viewModel.lastChosenOption == "choice1" &&
               viewModel.currentEvent?.illBeing1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice1" &&
               viewModel.currentEvent?.illBeing1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.illBeing1 ?? 0
                shouldShowIndicator = true
            }
            
            if viewModel.lastChosenOption == "choice2" &&
               viewModel.currentEvent?.illBeing2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice2" &&
               viewModel.currentEvent?.illBeing2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.illBeing2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "environmentalDegradation" {
            if viewModel.lastChosenOption == "choice1" &&
               viewModel.currentEvent?.environmentalDegradation1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice1" &&
                viewModel.currentEvent?.environmentalDegradation1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.environmentalDegradation1 ?? 0
                shouldShowIndicator = true
            }

            if viewModel.lastChosenOption == "choice2" &&
               viewModel.currentEvent?.environmentalDegradation2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice2" &&
                viewModel.currentEvent?.environmentalDegradation2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.environmentalDegradation2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        else if indicator == "sociopoliticalInstability" {
            if viewModel.lastChosenOption == "choice1" &&
               viewModel.currentEvent?.socioPoliticalInstability1 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice1" &&
                viewModel.currentEvent?.socioPoliticalInstability1 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.socioPoliticalInstability1 ?? 0
                shouldShowIndicator = true
            }
            
            if viewModel.lastChosenOption == "choice2" &&
               viewModel.currentEvent?.socioPoliticalInstability2 ?? 0 > 0 {
                valueIsIncreasing = true
                value = viewModel.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
            else if viewModel.lastChosenOption == "choice2" &&
                viewModel.currentEvent?.socioPoliticalInstability2 ?? 0 < 0 {
                valueIsIncreasing = false
                value = viewModel.currentEvent?.socioPoliticalInstability2 ?? 0
                shouldShowIndicator = true
            }
        }
        
        scaleChange = 1
    }
}

