//
//  GlitchTest.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 22/10/24.
//

import SwiftUI
import Design_System

struct GlitchTextEffect: View {
    var text: String?
    var intensity: CGFloat = 1.0
    
    @State private var trigger = false
    @State var timer: Timer?
    @State var duration: Float = 3
    
    var body: some View {
        VStack {
            ZStack {
                glitchTextView(text ?? "", trigger: trigger, intensity: intensity)
                    .font(.largeTitleFont)
                    .foregroundStyle(Assets.Colors.alert.swiftUIColor)
            }
        }
        .onAppear {
            startGlitchTimer()
        }
    }
    
    @ViewBuilder
    func glitchTextView(_ text: String, trigger: Bool, intensity: CGFloat) -> some View {
        ZStack {
            GlitchView(text: text, trigger: trigger, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(),
                    duration: 0.1)
            })
            
            GlitchView(text: text, trigger: trigger, shadow: .green, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: 0, shadowOpacity: 0.2 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.3 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: -5, shadowOpacity: 0.7 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: -5, shadowOpacity: 0.5 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: -5, bottom: 0, shadowOpacity: 0.15 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(),
                    duration: 0.1)
            })
            
            GlitchView(text: text, trigger: trigger, shadow: .yellow, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.15 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.4 * intensity),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: -2, shadowOpacity: 0.75 * intensity),
                    duration: 0.1)
                
                LinearKeyframe(
                    GlitchFrame(),
                    duration: 0.1)
            })
        }
    }
    
    func startGlitchTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) {_ in
            trigger.toggle()
            duration -= 0.4
            if self.duration < 0 {
                stopGlitchTimer()
                duration = duration
            }
        }
        
    }
    
    func stopGlitchTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    GlitchTextEffect(text: "Game Over")
}
