//
//  ChaosIndicatorsViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 14/10/24.
//

import Foundation
import SwiftUI

@Observable
class ChaosIndicatorsViewModel {
    var gameplayVM: GameplayViewModel
    var gameEngine: GameEngine
    
    init(gameplayVM: GameplayViewModel, gameEngine: GameEngine) {
        self.gameplayVM = gameplayVM
        self.gameEngine = gameEngine
    }
    
    func animateIndicatorsChange() {
        // stopped showing consequence: stop showing indicator and reset value
        if gameEngine.state != .consequence {
            gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 0
            gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 0
            gameplayVM.illBeingDecreaseShadowRadius = 0
            gameplayVM.illBeingIncreaseShadowRadius = 0
            gameplayVM.environmentalDegradationDecreaseShadowRadius = 0
            gameplayVM.environmentalDegradationIncreaseShadowRadius = 0
            return
        }
        
        if let event = gameEngine.currentEvent {
            if gameEngine.lastChosenOption == "choice1" {
                if event.environmentalDegradation1 > 0 {
                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation1 < 0 {
                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing1 > 0 {
                    gameplayVM.illBeingIncreaseShadowRadius = 7
                } else if event.illBeing1 < 0 {
                    gameplayVM.illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability1 > 0 {
                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability1 < 0 {
                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
            
            else if gameEngine.lastChosenOption == "choice2" {
                if event.environmentalDegradation2 > 0 {
                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation2 < 0 {
                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing2 > 0 {
                    gameplayVM.illBeingIncreaseShadowRadius = 7
                } else if event.illBeing2 < 0 {
                    gameplayVM.illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability2 > 0 {
                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability2 < 0 {
                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
        }
    }
    
    // Overlay view to show the indicator's value
    func overlayView(for indicator: Int) -> some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundStyle(Color(UIColor.systemRed))
                .frame(height: CGFloat(indicator) / 12 * geometry.size.height)
                .frame(maxHeight: geometry.size.height, alignment: .bottom)
        }
    }

    // Indicator view with an added percentage
    func indicatorView(for indicator: Int, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.08,
                       height: UIScreen.main.bounds.height * 0.04)
                .foregroundStyle(Color(UIColor.systemGray))
        }
    }
}
