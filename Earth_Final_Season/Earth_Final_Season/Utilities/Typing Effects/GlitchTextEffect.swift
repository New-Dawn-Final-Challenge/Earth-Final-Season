//
//  GlitchTest.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 22/10/24.
//

import SwiftUI

struct GlitchTextEffect: View {
    var text: String?
    @State private var trigger = false
    @State var timer: Timer?
    @State var duration: Float = 3
    var body: some View {
        VStack {
            ZStack {
                glitchTextView(text ?? "", trigger: trigger)
                    .font(.system(size: 70, weight: .semibold))
            }
        }
        .onAppear {
            startGlitchTimer()
        }
    }
    @ViewBuilder
    func glitchTextView(_ text: String, trigger: Bool) -> some View {
        ZStack {
            GlitchView(text: text, trigger: trigger, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(),
                    duration: 0.1)
            })
            
            GlitchView(text: text, trigger: trigger, shadow: .green, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: 0, shadowOpacity: 0.2),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.3),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: -5, shadowOpacity: 0.7),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: -5, shadowOpacity: 0.5),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: -5, bottom: 0, shadowOpacity: 0.15),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(),
                    duration: 0.1)
            })
            
            GlitchView(text: text, trigger: trigger, shadow: .yellow, radius: 1, frames: {
                LinearKeyframe(
                    GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.15),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.4),
                    duration: 0.1)
                LinearKeyframe(
                    GlitchFrame(top: 0, center: 5, bottom: -2, shadowOpacity: 0.75),
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
