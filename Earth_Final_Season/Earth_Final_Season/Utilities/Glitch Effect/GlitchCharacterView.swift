//
//  GlitchCharacterView.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 06/11/24.
//

import SwiftUI
import Design_System

struct GlitchCharacterView: View {
    @Binding var trigger: Bool
    @State private var glitchCharacterTimer: Timer? = nil
    private let glitchCharacterInterval: TimeInterval = 1.0
    let characterName: String
    var intensity: CGFloat = 1.0
    
    var body: some View {
        VStack {
            ZStack {
                glitchTextView(characterName, trigger: trigger, intensity: intensity)
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            startGlitchTimer()
        }
    }
    
    func startGlitchTimer() {
        glitchCharacterTimer = Timer.scheduledTimer(withTimeInterval: glitchCharacterInterval, repeats: false) { _ in
            trigger.toggle()
        }
    }
    
    @ViewBuilder
    func glitchTextView(_ text: String, trigger: Bool, intensity: CGFloat) -> some View {
        VStack {
            GlitchCharacterEffect(text: text, trigger: trigger, shadow: .green, radius: 1, frames: {
                LinearKeyframe(
                    CharacterGlitch(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    CharacterGlitch(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    CharacterGlitch(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    CharacterGlitch(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    CharacterGlitch(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    CharacterGlitch(),
                    duration: 0.1)
            })
        }
        .padding()
    }
}
