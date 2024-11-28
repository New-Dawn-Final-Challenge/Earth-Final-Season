import Foundation
import AVFoundation

class SoundtrackAudioManager: NSObject, AVAudioPlayerDelegate {
    
    static let shared = SoundtrackAudioManager()
    private var soundEffectsVolume: Float = 1.0
    private var soundtrackPlayer: AVAudioPlayer?
    private var newSoundtrackPlayer: AVAudioPlayer?
    private var soundEffectPlayers: [AVAudioPlayer] = []
    
    var isSoundtrackPlaying: Bool {
        return soundtrackPlayer?.isPlaying ?? false
    }
    
    var soundtrackPlaybackPosition: TimeInterval = 0
    
    // MARK: - Soundtrack Methods
    func playSoundtrack(named name: String, fileExtension: String = "mp3") {
        
        guard let musicUrl = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
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
        print("changed volume to \(intensity)")
        soundtrackPlayer?.volume = intensity
    }
    
    // MARK: - Crossfade Transition Method
    func crossfadeToNewSoundtrack(named newSoundtrackName: String, duration: TimeInterval) {
        
        // Fade out the current soundtrack
        fadeOutCurrentSoundtrack(duration: duration) { [weak self] in
            guard let self = self else { return }
            
            // After fade-out, start the new soundtrack with a fade-in
            self.playNewSoundtrack(named: newSoundtrackName)
            self.fadeInNewSoundtrack(duration: duration)
//            print("switched to new soundtrack")
        }
    }
    
    // MARK: - Fade-Out Method
    private func fadeOutCurrentSoundtrack(duration: TimeInterval, completion: @escaping () -> Void) {
        guard let player = soundtrackPlayer else {
            completion()
            return
        }
        
        let fadeOutInterval = 0.1
        let totalSteps = Int(duration / fadeOutInterval)
        var currentStep = 0
        
        Timer.scheduledTimer(withTimeInterval: fadeOutInterval, repeats: true) { timer in
            player.volume -= Float(1.0 / Double(totalSteps))
            currentStep += 1
            if currentStep >= totalSteps {
                player.stop()
                timer.invalidate()
                completion()
            }
        }
    }
    
    // MARK: - Fade-In New Soundtrack Method
    private func playNewSoundtrack(named name: String, fileExtension: String = "mp3") {
        guard let newMusicUrl = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            print("New soundtrack file not found")
            return
        }
        
        do {
            newSoundtrackPlayer = try AVAudioPlayer(contentsOf: newMusicUrl)
            newSoundtrackPlayer?.volume = 0 // Start with volume at 0 for fade-in
            newSoundtrackPlayer?.numberOfLoops = -1
            newSoundtrackPlayer?.prepareToPlay()
            newSoundtrackPlayer?.play()
        } catch {
            print("Error playing new soundtrack: \(error.localizedDescription)")
        }
    }
    
    private func fadeInNewSoundtrack(duration: TimeInterval) {
        guard let player = newSoundtrackPlayer else { return }
        
        let fadeInInterval = 0.1
        let totalSteps = Int(duration / fadeInInterval)
        var currentStep = 0
        
        Timer.scheduledTimer(withTimeInterval: fadeInInterval, repeats: true) { timer in
            player.volume += Float(1.0 / Double(totalSteps))
            currentStep += 1
            if currentStep >= totalSteps {
                // Replace the old soundtrack player with the new one and reset
                self.soundtrackPlayer = player
                self.newSoundtrackPlayer = nil
                timer.invalidate()
            }
        }
    }
    
    // MARK: - Sound Effects Methods
    func playSoundEffect(named name: String, fileExtension: String = "mp3", volume: Float = 1.0) {
        guard let effectUrl = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            print("Sound effect file not found")
            return
        }
        do {
            let soundEffectPlayer = try AVAudioPlayer(contentsOf: effectUrl)
            soundEffectPlayer.delegate = self
            soundEffectPlayer.prepareToPlay()
            soundEffectPlayer.play()
            soundEffectPlayer.volume = volume * soundEffectsVolume
            
            soundEffectPlayers.append(soundEffectPlayer)
//            print("played sound effect")
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
        print("changing SFX volume to \(intensity)")
        soundEffectsVolume = intensity
    }
    
    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = soundEffectPlayers.firstIndex(of: player) {
            soundEffectPlayers.remove(at: index)
        }
    }
}
