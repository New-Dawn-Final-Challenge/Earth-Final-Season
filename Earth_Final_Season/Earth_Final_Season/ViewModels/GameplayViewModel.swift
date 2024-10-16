//
//  GameplayViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import Foundation
import SwiftUI

protocol GameEngineDelegate: AnyObject {
    func gameStateChanged(to state: States)
}

@Observable
class GameplayViewModel: GameEngineDelegate {
    
    weak var engine: GameEngine?
    
    var environmentalDegradationDecreaseShadowRadius = 0
    var environmentalDegradationIncreaseShadowRadius = 0
    var environmentalDegradationShadowRadius = 0
    var illBeingDecreaseShadowRadius = 0
    var illBeingIncreaseShadowRadius = 0
    var illBeingShadowRadius = 0
    var currentPosition: CGSize = .zero
    var mainScreenShadowRadius = 0
    var option1ShadowRadius = 0
    var option2ShadowRadius = 0
    var sociopoliticalInstabilityDecreaseShadowRadius = 0
    var sociopoliticalInstabilityIncreaseShadowRadius = 0
    var sociopoliticalInstabilityShadowRadius = 0
    var currentState: States = .initializing
    var currentEvent: Event?
    
    var timer: Timer?
    var countdown = 6
    
    var scaleChange: CGFloat = 0
    var shouldShowIndicator: Bool = false
    var valueIsIncreasing: Bool = false
    var value: Int = 0
    
    func gameStateChanged(to state: States) {
        if state == .choosing {
            currentEvent = getEvent()
            currentState = .choosing
        }
        if state == .consequence {
            currentState = .consequence
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.countdown > 0 {
                    self.countdown -= 1
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.countdown = 6
                    
                    self.engine?.goToNextEvent()
                    if !(self.engine?.gameEnded() ?? true) {
                        self.currentState = .choosing
                    }
                }
            }
        }
        if state == .gameOver {
            currentState = .gameOver
        }
    }
    
    func getEvent() -> Event? {
        currentEvent = engine?.currentEvent
        return currentEvent
    }
    
    func getIndicators() -> Indicators? {
        return engine?.indicators
    }
    
    func chooseOption1() {
        //User feedback
        engine?.chooseOption1()
    }
    
    
    func chooseOption2() {
        //User feedback
        engine?.chooseOption2()
    }
    
    
    func animateIndicatorsChange() {
        // stopped showing consequence: stop showing indicator and reset value
        if  currentState != .consequence {
            sociopoliticalInstabilityDecreaseShadowRadius = 0
            sociopoliticalInstabilityIncreaseShadowRadius = 0
            illBeingDecreaseShadowRadius = 0
            illBeingIncreaseShadowRadius = 0
            environmentalDegradationDecreaseShadowRadius = 0
            environmentalDegradationIncreaseShadowRadius = 0
            return
        }
        
        if let event = currentEvent {
            if engine?.lastChosenOption == "choice1" {
                if event.environmentalDegradation1 > 0 {
                    environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation1 < 0 {
                    environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing1 > 0 {
                    illBeingIncreaseShadowRadius = 7
                } else if event.illBeing1 < 0 {
                    illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability1 > 0 {
                    sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability1 < 0 {
                    sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
            
            else if engine?.lastChosenOption == "choice2" {
                if event.environmentalDegradation2 > 0 {
                    environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation2 < 0 {
                    environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing2 > 0 {
                    illBeingIncreaseShadowRadius = 7
                } else if event.illBeing2 < 0 {
                    illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability2 > 0 {
                    sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability2 < 0 {
                    sociopoliticalInstabilityDecreaseShadowRadius = 7
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
    
    func getIndicatorValue(indicator: String) {
        // stopped showing consequence: stop showing indicator and reset value
        if  currentState != .consequence {
            value = 0
            scaleChange = 0
            shouldShowIndicator = false
            return
        }
        
        let illBeing = [engine?.currentEvent?.illBeing1, engine?.currentEvent?.illBeing2]
        let environmentalDegradation = [engine?.currentEvent?.environmentalDegradation1,
                                        engine?.currentEvent?.environmentalDegradation2]
        let socioPoliticalInstability = [engine?.currentEvent?.socioPoliticalInstability1,
                                          engine?.currentEvent?.socioPoliticalInstability2]
        
        var optionToget = 0
        switch engine?.lastChosenOption {
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
        
//        if indicator == "illBeing" {
//            if engine?.lastChosenOption == "choice1" &&
//                engine?.currentEvent?.illBeing1 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.illBeing1 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice1" &&
//                        engine?.currentEvent?.illBeing1 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.illBeing1 ?? 0
//                shouldShowIndicator = true
//            }
//            
//            if engine?.lastChosenOption == "choice2" &&
//                engine?.currentEvent?.illBeing2 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.illBeing2 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice2" &&
//                        engine?.currentEvent?.illBeing2 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.illBeing2 ?? 0
//                shouldShowIndicator = true
//            }
//        }
//        
//        else if indicator == "environmentalDegradation" {
//            if engine?.lastChosenOption == "choice1" &&
//                engine?.currentEvent?.environmentalDegradation1 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.environmentalDegradation1 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice1" &&
//                        engine?.currentEvent?.environmentalDegradation1 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.environmentalDegradation1 ?? 0
//                shouldShowIndicator = true
//            }
//
//            if engine?.lastChosenOption == "choice2" &&
//                engine?.currentEvent?.environmentalDegradation2 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.environmentalDegradation2 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice2" &&
//                        engine?.currentEvent?.environmentalDegradation2 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.environmentalDegradation2 ?? 0
//                shouldShowIndicator = true
//            }
//        }
//        
//        else if indicator == "sociopoliticalInstability" {
//            if engine?.lastChosenOption == "choice1" &&
//                engine?.currentEvent?.socioPoliticalInstability1 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.socioPoliticalInstability1 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice1" &&
//                        engine?.currentEvent?.socioPoliticalInstability1 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.socioPoliticalInstability1 ?? 0
//                shouldShowIndicator = true
//            }
//            
//            if engine?.lastChosenOption == "choice2" &&
//                engine?.currentEvent?.socioPoliticalInstability2 ?? 0 > 0 {
//                valueIsIncreasing = true
//                value = engine?.currentEvent?.socioPoliticalInstability2 ?? 0
//                shouldShowIndicator = true
//            }
//            else if engine?.lastChosenOption == "choice2" &&
//                        engine?.currentEvent?.socioPoliticalInstability2 ?? 0 < 0 {
//                valueIsIncreasing = false
//                value = engine?.currentEvent?.socioPoliticalInstability2 ?? 0
//                shouldShowIndicator = true
//            }
//        }
        
        scaleChange = 1
    }
}
