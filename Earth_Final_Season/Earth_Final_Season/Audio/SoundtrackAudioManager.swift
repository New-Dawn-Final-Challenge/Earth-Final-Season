//
//  AudioManager.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 30/09/24.
//

import Foundation
import AVFoundation

//esse manager é um singleton apenas para a trilha sonora
//para efeitos sonoros, vamos precisar de outro manager
//talvez seja interessante mudar depois para um MediaPlayerFramework pois
//mudar o som com AVFoundation se refere apenas ao som relativo ao sistema
class SoundtrackAudioManager {
    static let shared = SoundtrackAudioManager()
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    var playbackPosition: TimeInterval = 0
    
    func playSound(named name: String) {
        guard let musicUrl = Bundle.main.url(forResource: name, withExtension: "mp3") else {
                    print("Sound file not found")
                    return
        }
        do {
            if audioPlayer == nil || !isPlaying {
                audioPlayer = try AVAudioPlayer(contentsOf: musicUrl)
                audioPlayer?.currentTime = playbackPosition
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } else {
                print("Sound is already playing")
            }
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
        
    }
    func stopSound() {
        if let player = audioPlayer {
            playbackPosition = player.currentTime
            player.stop()
        }
    }
    func changeVolume(intensity: Float) {
        if let player = audioPlayer {
            player.volume = intensity
        }
    }
}
