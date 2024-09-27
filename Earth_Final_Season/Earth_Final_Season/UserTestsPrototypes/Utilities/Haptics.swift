//
//  Haptics.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 27/09/24.
//

import CoreHaptics

var engine: CHHapticEngine?

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
    
    for i in stride(from: 0, to: 0.5, by: 0.01) {
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
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
