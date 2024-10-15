//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChaosIndicatorsView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Environment(ChaosIndicatorsViewModel.self) private var chaosIndicatorsVM
    @Environment(GameEngine.self) private var gameEngine
    
    let illBeing: Int
    let socioPoliticalInstability: Int
    let environmentalDegradation: Int
    let year: String
    
    var body: some View {
        VStack {
            Text("Year: \(year)")
                .font(.system(size: 16))
                .bold()
                .padding(.bottom, 10)
            
            HStack(spacing: getWidth() * 0.1) {
                // Environmental Degradation indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(gameplayVM: gameplayVM, gameEngine: gameEngine, indicator: "environmentalDegradation")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    chaosIndicatorsVM.indicatorView(for: environmentalDegradation, image: "leaf.fill")
                        .overlay(
                            chaosIndicatorsVM.overlayView(for: environmentalDegradation)
                                .mask(chaosIndicatorsVM.indicatorView(for: environmentalDegradation, image: "leaf.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(gameplayVM.environmentalDegradationShadowRadius))
                }

                // Ill-being indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(gameplayVM: gameplayVM, gameEngine: gameEngine, indicator: "illBeing")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    chaosIndicatorsVM.indicatorView(for: illBeing, image: "person.fill")
                        .overlay(
                            chaosIndicatorsVM.overlayView(for: illBeing)
                                .mask(chaosIndicatorsVM.indicatorView(for: illBeing, image: "person.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.illBeingDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(gameplayVM.illBeingIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(gameplayVM.illBeingShadowRadius))
                }

                // Sociopolitical Instability with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(gameplayVM: gameplayVM, gameEngine: gameEngine, indicator: "sociopoliticalInstability")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    chaosIndicatorsVM.indicatorView(for: socioPoliticalInstability, image: "building.2.crop.circle.fill")
                        .overlay(
                            chaosIndicatorsVM.overlayView(for: socioPoliticalInstability)
                                .mask(chaosIndicatorsVM.indicatorView(for: socioPoliticalInstability, image: "building.2.crop.circle.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(gameplayVM.sociopoliticalInstabilityShadowRadius))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(UIColor.systemGray4))
        )
        .onChange(of: gameEngine.state == .consequence) {
            if gameEngine.state == .consequence {
                withAnimation(Animation.linear(duration: 1).repeatCount(3, autoreverses: true)) {
                    chaosIndicatorsVM.animateIndicatorsChange()
                }
            } else {
                withAnimation(Animation.linear(duration: 1)) {
                    chaosIndicatorsVM.animateIndicatorsChange()
                }
            }
        }
    }
}
