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
        let value1 = illBeing[optionToget] ?? 0
        let value2 = environmentalDegradation[optionToget] ?? 0
        let value3 = socioPoliticalInstability[optionToget] ?? 0
        
        
        if value1 < 0 {
            gameplayVM.illBeingDecreaseShadowRadius = 7
        } else if value1 > 0 {
            gameplayVM.illBeingIncreaseShadowRadius = 7
        }
        
        if value2 < 0 {
            gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
        } else if value2 > 0 {
            gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
        }
        
        if value3 < 0 {
            gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
        } else if value3 > 0 {
            gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
        }
        
        
//        if let event = gameEngine.currentEvent {
//            if gameEngine.lastChosenOption == "choice1" {
//                if event.environmentalDegradation1 > 0 {
//                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
//                } else if event.environmentalDegradation1 < 0 {
//                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
//                }
//                
//                if event.illBeing1 > 0 {
//                    gameplayVM.illBeingIncreaseShadowRadius = 7
//                } else if event.illBeing1 < 0 {
//                    gameplayVM.illBeingDecreaseShadowRadius = 7
//                }
//                
//                if event.socioPoliticalInstability1 > 0 {
//                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
//                } else if event.socioPoliticalInstability1 < 0 {
//                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
//                }
//            }
//            
//            else if gameEngine.lastChosenOption == "choice2" {
//                if event.environmentalDegradation2 > 0 {
//                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
//                } else if event.environmentalDegradation2 < 0 {
//                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
//                }
//                
//                if event.illBeing2 > 0 {
//                    gameplayVM.illBeingIncreaseShadowRadius = 7
//                } else if event.illBeing2 < 0 {
//                    gameplayVM.illBeingDecreaseShadowRadius = 7
//                }
//                
//                if event.socioPoliticalInstability2 > 0 {
//                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
//                } else if event.socioPoliticalInstability2 < 0 {
//                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
//                }
//            }
//        }
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
