//
//  MenuViewModel.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 14/11/24.
//
import Foundation

@Observable
class MenuViewModel {
    var firstTimePlaying = true {
        didSet {
            UserDefaults.standard.set(firstTimePlaying, forKey: Constants.MenuView.userDefaultsFirstTimePlayingKey)
        }
    }
    
    init() {
        // Load values from UserDefaults
        if UserDefaults.standard.object(forKey: Constants.MenuView.userDefaultsFirstTimePlayingKey) == nil {
            self.firstTimePlaying = true
        } else {
            self.firstTimePlaying = UserDefaults.standard.bool(forKey: Constants.MenuView.userDefaultsFirstTimePlayingKey)
        }
    }
}
