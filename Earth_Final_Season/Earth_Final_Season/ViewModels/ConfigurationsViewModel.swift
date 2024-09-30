//
//  ConfigurationsViewModel.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import Foundation

@Observable
class ConfigurationsViewModel {
    var soundEffectsIntensity: Double = 63.5
    var musicIntensity: Double = 33.5
    var hapticsEnabled = true
    var selectedGesture: Gesture = .HoldDrag
    var hapticsIntensity: Double = 1
}
