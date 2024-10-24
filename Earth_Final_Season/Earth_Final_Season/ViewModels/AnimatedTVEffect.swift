//
//  AnimatedTVEffect.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 23/10/24.
//

import SwiftUI

struct TestingEffect: View {
    @State private var elapsed: CGFloat = 0.0
    @State private var showEffect: Bool = false
    private let effectDuration: CGFloat = 1.0
    private let effectInterval: CGFloat = 10.0
    
    var body: some View {
        ZStack {
            VStack {
                GlitchImageView()
                    .scaledToFit()
                    .distortionEffect(
                        ShaderLibrary.wave(
                            .float(elapsed)), maxSampleOffset: .zero)
                
                Text("Static Noise Effect")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            
            MetalStaticNoiseView()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.55)
                .zIndex(3)
        }
        .ignoresSafeArea()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
                elapsed += 0.016
                
                if Int(elapsed) % Int(effectInterval) == 0 {
                    showEffect = true
                }
                
                if showEffect && elapsed.truncatingRemainder(dividingBy: effectInterval) > effectDuration {
                    showEffect = false
                }
            }
        }
    }
}

#Preview {
    TestingEffect()
}
