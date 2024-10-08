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
            UserDefaults.standard.set(musicIntensity, forKey: "musicIntensity")
        }
    }
        
    @Published var hapticsEnabled = true
    @Published var selectedGesture: Gesture = .holdDrag
    @Published var hapticsIntensity: Float = 100.0 {
        didSet {
            HapticManager.shared.setIntensity(hapticsIntensity/100)
            UserDefaults.standard.set(hapticsIntensity, forKey: "hapticsIntensity")
        }
    }
    init() {
            // Load values from UserDefaults
//            self.soundEffectsIntensity = UserDefaults.standard.float(forKey: "soundEffectsIntensity") != 0 ? UserDefaults.standard.float(forKey: "soundEffectsIntensity") : 63.5
            self.musicIntensity = UserDefaults.standard.float(forKey: "musicIntensity") != 0 ? UserDefaults.standard.float(forKey: "musicIntensity") : 33.5
            self.hapticsIntensity = UserDefaults.standard.float(forKey: "hapticsIntensity") != 0 ? UserDefaults.standard.float(forKey: "hapticsIntensity") : 100.0
//            self.hapticsEnabled = UserDefaults.standard.bool(forKey: "hapticsEnabled")
//            self.selectedGesture = Gesture(rawValue: UserDefaults.standard.integer(forKey: "selectedGesture")) ?? .holdDrag
        }
    
    func playMusic(music name: String) {
        SoundtrackAudioManager.shared.playSound(named: name)
    }
    func stopMusic() {
        SoundtrackAudioManager.shared.stopSound()
    }
}
