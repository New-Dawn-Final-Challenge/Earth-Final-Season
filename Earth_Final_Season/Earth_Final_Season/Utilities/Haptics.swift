//
//  Haptics.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 27/09/24.
//

import CoreHaptics

class HapticsManager {
    static let shared = HapticsManager()
    var engine: CHHapticEngine?
    var intensity: Float = Constants.Haptics.defaultIntensity
    
    func setIntensity(_ value: Float) {
        self.intensity = value
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: Constants.Haptics.relativeTimeLimit, by: Constants.Haptics.strideInterval) {
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i) * intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: Constants.Haptics.defaultSharpness)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: i)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern")
        }
    }
}
