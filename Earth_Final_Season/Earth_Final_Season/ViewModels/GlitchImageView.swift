//
//  GlitchImageView.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 24/10/24.
//

import SwiftUI

struct GlitchImageView: View {
    
    @State private var glitchOffset: CGFloat = 0.0
    @State private var glitchIntensity: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Image("image1")
                .resizable()
                .scaledToFit()
            
            Image("image1")
                .resizable()
                .scaledToFit()
                .colorMultiply(.red)
                .offset(x: glitchOffset, y: glitchOffset * 0.5)
                .blendMode(.screen)
            
            Image("image1")
                .resizable()
                .scaledToFit()
                .colorMultiply(.blue)
                .offset(x: -glitchOffset, y: -glitchOffset * 0.3)
                .blendMode(.screen)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 0.1).repeatForever(autoreverses: true)) {
                glitchOffset = CGFloat.random(in: -20...20) // Variação no deslocamento da imagem
                glitchIntensity = CGFloat.random(in: -2...2) // Variação na intensidade do glitch
            }
        }
    }
}

#Preview {
    GlitchImageView()
}
