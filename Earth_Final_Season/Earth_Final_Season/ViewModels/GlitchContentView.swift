//
//  GlitchContentView.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 25/10/24.
//

import SwiftUI

struct GlitchContentView: View {
    @State private var trigger: Bool = false
    @State private var glitchTimer: Timer? = nil
    private let glitchInterval: TimeInterval = 5.0 
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: "image1") {
                ZStack {
                    QuickGlitchEffect(image: uiImage, trigger: trigger) {
                        LinearKeyframe(GlitchFrame(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(), duration: 0.1)
                    }
                    .hidden()
                    
                    QuickGlitchEffect(image: uiImage, trigger: trigger, shadow: .green) {
                        LinearKeyframe(GlitchFrame(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: -5, shadowOpacity: 0.3),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: -5, center: -5, bottom: 5, shadowOpacity: 0.5),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1),
                                       duration: 0.1)
                        
                        LinearKeyframe(GlitchFrame(), duration: 0.1)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            startGlitchTimer()
        }
        .onDisappear {
            stopGlitchTimer()
        }
    }
    
    func startGlitchTimer() {
        glitchTimer = Timer.scheduledTimer(withTimeInterval: glitchInterval, repeats: true) { _ in
            trigger.toggle()
        }
    }
    
    func stopGlitchTimer() {
        glitchTimer?.invalidate()
        glitchTimer = nil
    }
}

#Preview {
    GlitchContentView()
}
