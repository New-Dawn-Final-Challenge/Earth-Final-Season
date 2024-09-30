//
//  ConfigurationsViewModel.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import Foundation

@Observable
class ConfigurationsViewModel {
    var soundEffectsIntensity: Float = 63.5
    var musicIntensity: Float = 33.5 {
        didSet {
            SoundtrackAudioManager.shared.changeVolume(intensity: musicIntensity/100)
        }
    }
        
    var hapticsEnabled = true
    var selectedGesture: Gesture = .HoldDrag
    var hapticsIntensity: Float = 1
    
    func playMusic(music name: String) {
        SoundtrackAudioManager.shared.playSound(named: name)
    }
    func stopMusic() {
        SoundtrackAudioManager.shared.stopSound()
    }
}
