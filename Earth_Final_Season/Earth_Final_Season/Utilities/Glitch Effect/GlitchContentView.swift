//
//  GlitchContentView.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 25/10/24.
//

import SwiftUI
import Design_System

struct GlitchContentView: View {
    @Binding var trigger: Bool
    @State private var glitchTimer: Timer? = nil
    private let glitchInterval: TimeInterval = 3.0
    let uiImage = Assets.Images.placeholderCharacter.swiftUIImage
    
    var body: some View {
        VStack {
            ZStack {
                QuickGlitchEffect(image: uiImage, trigger: trigger) {
                    LinearKeyframe(GlitchFrameImage(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: -5, center: -5, bottom: -5, shadowOpacity: 0.6),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: -5, center: -5, bottom: 5, shadowOpacity: 0.8),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(), duration: 0.1)
                }
                .hidden()
                
                QuickGlitchEffect(image: uiImage, trigger: trigger, shadow: .green) {
                    LinearKeyframe(GlitchFrameImage(top: -5, center: 0, bottom: 0, shadowOpacity: 0.2),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: -5, center: -5, bottom: -5, shadowOpacity: 0.3),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: -5, center: -5, bottom: 5, shadowOpacity: 0.5),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: 5, center: 5, bottom: 5, shadowOpacity: 0.4),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(top: 5, center: 0, bottom: 5, shadowOpacity: 0.1),
                                   duration: 0.1)
                    
                    LinearKeyframe(GlitchFrameImage(), duration: 0.1)
                }
            }
        }
        .padding()
        .onAppear {
            startGlitchTimer()
        }
    }
    
    func startGlitchTimer() {
            trigger.toggle()
    }
}
