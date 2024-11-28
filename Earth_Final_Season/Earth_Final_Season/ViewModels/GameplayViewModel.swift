import Foundation
import SwiftUI
import Design_System
import Combine

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
    var currentEvent: Event?
    
    var isPaused = false
    var timer: Timer?
    var countdown = Constants.GameplayViewModel.countdownStartValue
    var specialEnding = false
    var progress: Double = 0
    private var displayLink: CADisplayLink?
    private var lastUpdatedTime: CFTimeInterval = 0
    
    var scaleChange: [CGFloat] = Array(repeating: Constants.GameplayViewModel.indicatorInitialScale, count: 3)
    var shouldShowIndicator: [Bool] = Array(repeating: false, count: 3)
    var valueIsIncreasing: [Bool] = Array(repeating: false, count: 3)
    var value: [Int] = Array(repeating: 0, count: 3)
    
    // for special game over
    var specialGameOverImage: Image?
    var specialGameOverText: String?
    
    private var allCharacters: [String] = [
        "ultra new age environmentalist",
        "sensationalist tv host",
        "questionable religious leader",
        "evil researcher",
        "slow logistics engineer",
        "indie physician",
        "president in denial",
        "chaotic billionaire",
        "experimentalist geneticist",
        "chronically online teenager",
        "fearless economist",
        "convincing conspiracy theorist",
        "apocalyptical cat",
        "robot vacuum cleaner"
    ]
    
    init() {
        loadUnlockedCharacters()
    }
    
    func loadUnlockedCharacters() {
        guard let engine = engine else {
            print("Engine not initialized.")
            return
        }

        if let savedCharacters = UserDefaults.standard.array(forKey: "unlockedCharacters") as? [String] {
            engine.unlockedCharacters = savedCharacters
        }
    }
    
    func unlockNextCharacter() {
        guard let engine = engine else { return }
        
        let lockedCharacters = allCharacters.filter { !engine.unlockedCharacters.contains($0.lowercased()) }
        guard let nextCharacter = lockedCharacters.first else {
            print("All characters are already unlocked.")
            return
        }

        engine.unlockedCharacters.append(nextCharacter.lowercased())
        engine.events = engine.filterUnlockedEvents(from: engine.allEvents)
        print("Unlocked character: \(nextCharacter)")
        printUnlockedCharacters()
        
        saveUnlockedCharacters()
    }
    
    func printUnlockedCharacters() {
        guard let engine = engine else {
            print("Engine not initialized.")
            return
        }
        
        if engine.unlockedCharacters.isEmpty {
            print("No characters unlocked yet.")
        } else {
            print("Unlocked characters:")
            for character in engine.unlockedCharacters {
                print("- \(character)")
            }
        }
    }
    
    func getUnlockedCharacters() -> [String] {
        guard let engine = engine else {
            print("Engine not initialized.")
            return []
        }
        return engine.unlockedCharacters
    }
    
    var unlockedCharacterCount: Int {
        guard let engine = engine else {
            return 0
        }
        return engine.unlockedCharacters.count
    }
    
    var totalCharacterCount: Int {
        return allCharacters.count
    }
    
    func saveUnlockedCharacters() {
        guard let engine = engine else {
            print("Engine not initialized.")
            return
        }

        UserDefaults.standard.set(engine.unlockedCharacters, forKey: "unlockedCharacters")
    }

    func gameStateChanged(to state: States) {
        
        switch (state) {
        case .choosing:
            currentEvent = getEvent()
            resetTimer()
            
        case .consequence:
            startTimer()
            
        default:
            return
        }
    }
    
    func resetTimer() {
        displayLink?.invalidate()
        displayLink = nil
        progress = 0
    }
    
    func startTimer() {
        resetTimer()
        displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        displayLink?.add(to: .main, forMode: .common)
        lastUpdatedTime = CACurrentMediaTime()
    }
    
    func skipTimer() {
        resumeTimer()
        progress = 1.0
    }
    
    func pauseTimer() {
        isPaused = true
        lastUpdatedTime = CACurrentMediaTime()
    }
    
    func resumeTimer() {
        isPaused = false
        lastUpdatedTime = CACurrentMediaTime()
    }
        
    func togglePause() {
        if isPaused {
            resumeTimer()
        } else {
            pauseTimer()
        }
    }
    
    @objc private func updateTimer(displayLink: CADisplayLink) {
        if isPaused {
            return
        }
            
        let currentTime = CACurrentMediaTime()
        let deltaTime = currentTime - lastUpdatedTime
        lastUpdatedTime = currentTime
            
        progress += deltaTime / Double(countdown)
            
            if progress >= 1.0 {
                resetTimer()
                engine?.goToNextEvent()
            }
        }
    
    func getState() -> States? {
        return engine?.state
    }
    
    func getEvent() -> Event? {
        return engine?.currentEvent
    }
    
    func getIndicators() -> Indicators? {
        return engine?.indicators
    }
    
    func getGameOverTitle() -> String? {
        return engine?.gameOverTitle
    }
    
    func getGameOverReason() -> String? {
        return engine?.gameOverReason
    }
    
    func getGameOverImage() -> Image? {
        return engine?.gameOverImage
    }
    
    func getLastChosenOption() -> String? {
        return engine?.lastChosenOption
    }
    
    func chooseOption(option: Int) {
        engine?.chooseOption(option: option)
        SoundtrackAudioManager.shared.playSoundEffect(named: "choice")
    }
    
    func resetGame() {
        unlockNextCharacter()
        engine?.resetGame()
    }
    
    func getIndicatorValue(indicator: String, nIndicator: Int) {
        // Stop showing indicator and reset values if not in consequence state
        guard getState() == .consequence else {
            scaleChange = Array(repeating: Constants.GameplayViewModel.indicatorInitialScale, count: 3)
            shouldShowIndicator = Array(repeating: false, count: 3)
            valueIsIncreasing = Array(repeating: false, count: 3)
            value = Array(repeating: 0, count: 3)
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
        scaleChange[nIndicator] = Constants.GameplayViewModel.indicatorVisibleScale
    }
    
    func animateIndicatorsChange() {
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
        
        var n_choice = 0
        
        switch engine?.lastChosenOption {
            case "choice1":
                n_choice = 0
            case "choice2":
                n_choice = 1
            default: break
        }
        
        let illBeingValue = illBeing[n_choice] ?? 0
        let envDegradationValue = environmentalDegradation[n_choice] ?? 0
        let socioPoliticalValue = socioPoliticalInstability[n_choice] ?? 0
        
        if illBeingValue < 0 {
            illBeingDecreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        } else if illBeingValue > 0 {
            illBeingIncreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        }
        
        if envDegradationValue < 0 {
            environmentalDegradationDecreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        } else if envDegradationValue > 0 {
            environmentalDegradationIncreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        }
        
        if socioPoliticalValue < 0 {
            sociopoliticalInstabilityDecreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        } else if socioPoliticalValue > 0 {
            sociopoliticalInstabilityIncreaseShadowRadius = Constants.GameplayViewModel.shadowRadiusHighlight
        }
    }
}
