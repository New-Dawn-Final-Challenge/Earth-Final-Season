//
//  ConfigurationsViewModel.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import Foundation


class ConfigurationsViewModel: ObservableObject {
    @Published var soundEffectsIntensity: Float = 63.5
    @Published var musicIntensity: Float = 33.5 {
        didSet {
            SoundtrackAudioManager.shared.changeVolume(intensity: musicIntensity/100)
        }
    }
        
    @Published var hapticsEnabled = true
    @Published var selectedGesture: Gesture = .holdDrag
    @Published var hapticsIntensity: Float = 100.0 {
        didSet {
            HapticManager.shared.setIntensity(hapticsIntensity/100)
        }
    }
    
    func playMusic(music name: String) {
        SoundtrackAudioManager.shared.playSound(named: name)
    }
    func stopMusic() {
        SoundtrackAudioManager.shared.stopSound()
    }
}
