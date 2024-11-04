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
    let animation: Animation = Animation.linear(duration: BackgroundViewConstants.animationDuration).repeatForever(autoreverses: true)
    
    var body: some View {
        ZStack {
            let config: EmitterConfig = EmitterConfig(
                emitter: Emitters.starField,
                size: CGSize(width: 1, height: 1),
                shape: .rectangle,
                position: CGPoint(x: getWidth() / 2, y: getHeight() / 2),
                name: "Star Field",
                background: ""
            )
            
            Color(red: BackgroundViewConstants.colorRed,
                  green: BackgroundViewConstants.colorGreen,
                  blue: BackgroundViewConstants.colorBlue)
                .edgesIgnoringSafeArea(.all)
            
            TimelineView(.animation) { context in
                Assets.Images.sparkles.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: getWidth(), height: getHeight())
                    .opacity(BackgroundViewConstants.opacity)
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
            
            GeometryReader { geometry in
                VStack(spacing: 100) {
                    Assets.Images.nebula.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: getWidth(), height: getHeight())
                        .rotationEffect(.degrees(animate ? BackgroundViewConstants.firstRotationAngle : 0))
                        .scaleEffect(animate ? BackgroundViewConstants.scaleEffectValue : BackgroundViewConstants.scaleEffectValue)
                        .animation(.easeInOut(duration: BackgroundViewConstants.animationRepeatDuration).repeatForever(autoreverses: true), value: animate)
                        .frame(width: BackgroundViewConstants.frameWidth1, height: BackgroundViewConstants.frameHeight1,
                               alignment: animate ? .bottomLeading : .trailing)
                    
                    Assets.Images.nebula.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: getWidth(), height: getHeight())
                        .rotationEffect(.degrees(animate ? BackgroundViewConstants.secondRotationAngle : 0))
                        .scaleEffect(animate ? 2.0 : 2.0)
                        .animation(.easeInOut(duration: BackgroundViewConstants.animationRepeatDuration).repeatForever(autoreverses: true), value: animate)
                        .frame(width: BackgroundViewConstants.frameWidth2, height: BackgroundViewConstants.frameHeight2,
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
                    .cornerRadius(BackgroundViewConstants.emitterCornerRadius)
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
