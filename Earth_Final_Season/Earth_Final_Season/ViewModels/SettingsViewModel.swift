//
//  ConfigurationsViewModel.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import Foundation

@Observable
class SettingsViewModel {
    var soundEffectsIntensity: Float = 63.5
    
    var musicIntensity: Float = 33.5 {
        didSet {
            SoundtrackAudioManager.shared.changeVolume(intensity: musicIntensity / 100)
            UserDefaults.standard.set(musicIntensity, forKey: "musicIntensity")
        }
    }
        
    var hapticsEnabled = true {
        didSet {
            UserDefaults.standard.set(hapticsEnabled, forKey: "hapticsEnabled")
        }
    }
    
    var selectedGesture: Gesture = .holdDrag {
        didSet {
            UserDefaults.standard.set(selectedGesture.rawValue, forKey: "selectedGesture")
            print("saved \(selectedGesture.rawValue)")
        }
    }
    
    var hapticsIntensity: Float = 1 {
        didSet {
            HapticsManager.shared.setIntensity(hapticsIntensity / 100)
            UserDefaults.standard.set(hapticsIntensity, forKey: "hapticsIntensity")
        }
    }
    
    init() {
        // Load values from UserDefaults
        self.musicIntensity = UserDefaults.standard.float(forKey: "musicIntensity") != 0 ? UserDefaults.standard.float(forKey: "musicIntensity") : 33.5
        self.hapticsIntensity = UserDefaults.standard.float(forKey: "hapticsIntensity") != 0 ? UserDefaults.standard.float(forKey: "hapticsIntensity") : 100.0
        self.hapticsEnabled = UserDefaults.standard.bool(forKey: "hapticsEnabled")
        
        let rawValue = UserDefaults.standard.integer(forKey: "selectedGesture")
        print("raw value: \(rawValue)")
        
        self.selectedGesture = Gesture(rawValue: rawValue) ?? .holdDrag
        }
    
    func playMusic(music name: String) {
        SoundtrackAudioManager.shared.playSoundtrack(named: name)
    }
    
    func stopMusic() {
        SoundtrackAudioManager.shared.stopSoundtrack()
    }
}
