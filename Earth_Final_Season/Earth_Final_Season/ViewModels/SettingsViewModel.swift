//
//  ConfigurationsViewModel.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import Foundation

@Observable
class SettingsViewModel {
    var soundEffectsIntensity: Float = Constants.Settings.soundEffectsDefaultIntensity
    var musicIntensity: Float = Constants.Settings.defaultMusicIntensity {
        didSet {
            SoundtrackAudioManager.shared.changeVolume(intensity: musicIntensity / Constants.Settings.maxIntensity)
            UserDefaults.standard.set(musicIntensity, forKey: Constants.Settings.userDefaultsMusicKey)
        }
    }
        
    var hapticsEnabled = true {
        didSet {
            UserDefaults.standard.set(hapticsEnabled, forKey: Constants.Settings.userDefaultsHapticsEnabledKey)
        }
    }
    var selectedGesture: Gesture = .holdDrag {
        didSet {
            UserDefaults.standard.set(selectedGesture.rawValue, forKey: Constants.Settings.userDefaultsGestureKey)
            print("saved \(selectedGesture.rawValue)")
        }
    }
    var hapticsIntensity: Float = Constants.Settings.maxIntensity {
        didSet {
            HapticsManager.shared.setIntensity(hapticsIntensity / Constants.Settings.maxIntensity)
            UserDefaults.standard.set(hapticsIntensity, forKey: Constants.Settings.userDefaultsHapticsKey)
        }
    }

    init() {
        // Load values from UserDefaults
        self.musicIntensity = UserDefaults.standard.float(forKey: Constants.Settings.userDefaultsMusicKey) != 0
            ? UserDefaults.standard.float(forKey: Constants.Settings.userDefaultsMusicKey)
            : Constants.Settings.defaultMusicIntensity
        
        self.hapticsIntensity = UserDefaults.standard.float(forKey: Constants.Settings.userDefaultsHapticsKey) != 0
            ? UserDefaults.standard.float(forKey: Constants.Settings.userDefaultsHapticsKey)
            : Constants.Settings.maxIntensity
        
        self.hapticsEnabled = UserDefaults.standard.bool(forKey: Constants.Settings.userDefaultsHapticsEnabledKey)
        
        let rawValue = UserDefaults.standard.integer(forKey: Constants.Settings.userDefaultsGestureKey)
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

