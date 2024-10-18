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
    
    var scaleChange: [CGFloat] = [0,0,0]
    var shouldShowIndicator: [Bool] = [false,false,false]
    var valueIsIncreasing: [Bool] = [false,false,false]
    var value: [Int] = [0,0,0]
    
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
    
    func chooseOption(option: Int) {
        engine?.chooseOption(option: option)
    }
    
    func getIndicatorValue(indicator: String, nIndicator: Int) {
        
        // Stop showing indicator and reset values if not in consequence state
        guard currentState == .consequence else {
            scaleChange = [0,0,0]
            shouldShowIndicator = [false, false, false]
            valueIsIncreasing = [false, false, false]
            value = [0,0,0]
            return
        }
        
        let event = engine?.currentEvent
        let indicatorValues: [String: [Int?]] = [
            "environmentalDegradation": [event?.environmentalDegradation1, event?.environmentalDegradation2],
            "illBeing": [event?.illBeing1, event?.illBeing2],
            "socioPoliticalInstability": [event?.socioPoliticalInstability1, event?.socioPoliticalInstability2]
        ]
        
        let optionIndex = engine?.lastChosenOption == "choice2" ? 1 : 0
        let chosenValue = indicatorValues[indicator]?[optionIndex] ?? 0
        
        value[nIndicator] = chosenValue
        valueIsIncreasing[nIndicator] = value[nIndicator] > 0
        shouldShowIndicator[nIndicator] = value[nIndicator] != 0
        scaleChange[nIndicator] = 1
    }
    
    func animateIndicatorsChange() {
        // stopped showing consequence: stop showing indicator and reset value
        if engine?.state != .consequence {
            sociopoliticalInstabilityDecreaseShadowRadius = 0
            sociopoliticalInstabilityIncreaseShadowRadius = 0
            illBeingDecreaseShadowRadius = 0
            illBeingIncreaseShadowRadius = 0
            environmentalDegradationDecreaseShadowRadius = 0
            environmentalDegradationIncreaseShadowRadius = 0
            return
        }
        let environmentalDegradation = [engine?.currentEvent?.environmentalDegradation1,
                                        engine?.currentEvent?.environmentalDegradation2]
        
        let illBeing = [engine?.currentEvent?.illBeing1, engine?.currentEvent?.illBeing2]
        
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
        let value1 = illBeing[optionToget] ?? 0
        let value2 = environmentalDegradation[optionToget] ?? 0
        let value3 = socioPoliticalInstability[optionToget] ?? 0
        
        
        if value1 < 0 {
            illBeingDecreaseShadowRadius = 7
        } else if value1 > 0 {
            illBeingIncreaseShadowRadius = 7
        }
        
        if value2 < 0 {
            environmentalDegradationDecreaseShadowRadius = 7
        } else if value2 > 0 {
            environmentalDegradationIncreaseShadowRadius = 7
        }
        
        if value3 < 0 {
            sociopoliticalInstabilityDecreaseShadowRadius = 7
        } else if value3 > 0 {
            sociopoliticalInstabilityIncreaseShadowRadius = 7
        }
    }
}
