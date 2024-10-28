//
//  TestView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 23/10/24.
//

import SwiftUI
import MetalKit
import UIKit
import Design_System

struct BackgroundView: View {
    let startDate = Date()
    @State var animate: Bool = false
    let animation: Animation = Animation.linear(duration: 20.0).repeatForever(autoreverses: true)
    
    var body: some View {
        
        ZStack() {
            
            let config: EmitterConfig = EmitterConfig(emitter: Emitters.starField, size: CGSize(width: 1, height: 1), shape: .rectangle, position: CGPoint(x: getWidth() / 2, y: getHeight() / 2), name: "Star Field", background: "")
            
            Color(red: 0.208, green: 0.212, blue: 0.216)
                .edgesIgnoringSafeArea(.all)
            
            TimelineView(.animation) { context in
                Assets.Images.sparkles.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(width: getWidth(), height: getHeight())
                .opacity(0.7)
                .visualEffect { content, proxy in
                    content
                    .distortionEffect(ShaderLibrary.complexWave(
                        .float(startDate.timeIntervalSinceNow),
                        .float2(proxy.size),
                        .float(0.5),
                        .float(1),
                        .float(10)
                    ), maxSampleOffset: .zero)
                }
            }
            
            GeometryReader { geo in
                VStack(spacing: 100) {
                    Assets.Images.nebula.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: getWidth(), height: getHeight())
                    // Add rotation and scale effects
                        .rotationEffect(.degrees(animate ? -90 : 0)) // Full rotation
                        .scaleEffect(animate ? 1.5 : 1.5) // Scale up and down
                        .animation(.easeInOut(duration: 60).repeatForever(autoreverses: true), value: animate) // Rotation and scale animation
                        .frame(width: 100, height: -0,
                               alignment: animate ? .bottomLeading : .trailing)
                    
                    Assets.Images.nebula.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: getWidth(), height: getHeight())
                    // Add rotation and scale effects
                        .rotationEffect(.degrees(animate ? 60 : 0)) // Full rotation
                        .scaleEffect(animate ? 2.0 : 2.0) // Scale up and down
                        .animation(.easeInOut(duration: 60).repeatForever(autoreverses: true), value: animate) // Rotation and scale animation
                        .frame(width: 700, height: 1000,
                               alignment: animate ? .topLeading : .bottomTrailing)
                }
                .animation(animation, value: animate)
            }
            .onAppear {
                withAnimation(animation) {
                    animate.toggle()
                }
            }
            
            VStack(alignment: .leading) {
                config.emitter
                    .emitterSize(config.size)
                    .emitterShape(config.shape)
                    .emitterPosition(config.position)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: getHeight(),
                           maxHeight: .infinity,
                           alignment: Alignment.topLeading)
                    .cornerRadius(12)
            }
            
            Assets.Images.spaceShip.swiftUIImage
            .resizable()
            .scaledToFit()
            .frame(width: getWidth(), height: getHeight())
        }
    }
}

#Preview {
    BackgroundView()
}
