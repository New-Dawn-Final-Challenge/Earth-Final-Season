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
}
