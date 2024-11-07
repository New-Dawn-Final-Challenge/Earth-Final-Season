import Foundation
import AVFoundation

class SoundtrackAudioManager {
    
    static let shared = SoundtrackAudioManager()
    private var soundtrackPlayer: AVAudioPlayer?
    private var soundEffectPlayers: [AVAudioPlayer] = []
    
    var isSoundtrackPlaying: Bool {
        return soundtrackPlayer?.isPlaying ?? false
    }
    
    var soundtrackPlaybackPosition: TimeInterval = 0
    
    // MARK: - Soundtrack Methods
    func playSoundtrack(named name: String) {
        
        guard let musicUrl = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Soundtrack file not found")
            return
        }
        
        do {
            if soundtrackPlayer == nil || !isSoundtrackPlaying {
                soundtrackPlayer = try AVAudioPlayer(contentsOf: musicUrl)
                soundtrackPlayer?.currentTime = soundtrackPlaybackPosition
                soundtrackPlayer?.numberOfLoops = -1 // Loop the soundtrack
                soundtrackPlayer?.prepareToPlay()
                soundtrackPlayer?.play()
            } else {
                print("Soundtrack is already playing")
            }
        } catch {
            print("Error playing soundtrack: \(error.localizedDescription)")
        }
    }
    
    func stopSoundtrack() {
        if let player = soundtrackPlayer {
            soundtrackPlaybackPosition = player.currentTime
            player.stop()
        }
    }
    
    func changeVolume(intensity: Float) {
        soundtrackPlayer?.volume = intensity
    }
    
    // MARK: - Sound Effects Methods
    func playSoundEffect(named name: String) {
        guard let effectUrl = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound effect file not found")
            return
        }
        do {
            let soundEffectPlayer = try AVAudioPlayer(contentsOf: effectUrl)
            soundEffectPlayer.prepareToPlay()
            soundEffectPlayer.play()
            soundEffectPlayers.append(soundEffectPlayer)
        } catch {
            print("Error playing sound effect: \(error.localizedDescription)")
        }
    }
    
    func stopAllSoundEffects() {
        for player in soundEffectPlayers {
            player.stop()
        }
        soundEffectPlayers.removeAll()
    }
    
    func changeSoundEffectVolume(intensity: Float) {
        for player in soundEffectPlayers {
            player.volume = intensity
        }
    }
}
