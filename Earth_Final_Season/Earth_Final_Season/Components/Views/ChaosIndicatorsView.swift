//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChaosIndicatorsView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
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
                    ChaosIndicatorsValueChangeView(indicator: "environmentalDegradation")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    indicatorView(for: environmentalDegradation, image: "leaf.fill")
                        .overlay(
                            overlayView(for: environmentalDegradation)
                                .mask(indicatorView(for: environmentalDegradation, image: "leaf.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(gameplayVM.environmentalDegradationShadowRadius))
                }

                // Ill-being indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(indicator: "illBeing")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    indicatorView(for: illBeing, image: "person.fill")
                        .overlay(
                            overlayView(for: illBeing)
                                .mask(indicatorView(for: illBeing, image: "person.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.illBeingDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(gameplayVM.illBeingIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(gameplayVM.illBeingShadowRadius))
                }

                // Sociopolitical Instability with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(indicator: "sociopoliticalInstability")
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    indicatorView(for: socioPoliticalInstability, image: "building.2.crop.circle.fill")
                        .overlay(
                            overlayView(for: socioPoliticalInstability)
                                .mask(indicatorView(for: socioPoliticalInstability, image: "building.2.crop.circle.fill"))
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
        .onChange(of: gameplayVM.isShowingConsequence) {
            if gameplayVM.isShowingConsequence {
                withAnimation(Animation.linear(duration: 1).repeatCount(3, autoreverses: true)) {
                    animateIndicatorsChange()
                }
            } else {
                withAnimation(Animation.linear(duration: 1)) {
                    animateIndicatorsChange()
                }
            }
        }
    }
    
    func animateIndicatorsChange() {
        // stopped showing consequence: stop showing indicator and reset value
        if gameplayVM.isShowingConsequence == false {
            gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 0
            gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 0
            gameplayVM.illBeingDecreaseShadowRadius = 0
            gameplayVM.illBeingIncreaseShadowRadius = 0
            gameplayVM.environmentalDegradationDecreaseShadowRadius = 0
            gameplayVM.environmentalDegradationIncreaseShadowRadius = 0
            return
        }
        
        if let event = gameplayVM.currentEvent {
            if gameplayVM.lastChosenOption == "choice1" {
                if event.environmentalDegradation1 > 0 {
                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation1 < 0 {
                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing1 > 0 {
                    gameplayVM.illBeingIncreaseShadowRadius = 7
                } else if event.illBeing1 < 0 {
                    gameplayVM.illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability1 > 0 {
                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability1 < 0 {
                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
            
            else if gameplayVM.lastChosenOption == "choice2" {
                if event.environmentalDegradation2 > 0 {
                    gameplayVM.environmentalDegradationIncreaseShadowRadius = 7
                } else if event.environmentalDegradation2 < 0 {
                    gameplayVM.environmentalDegradationDecreaseShadowRadius = 7
                }
                
                if event.illBeing2 > 0 {
                    gameplayVM.illBeingIncreaseShadowRadius = 7
                } else if event.illBeing2 < 0 {
                    gameplayVM.illBeingDecreaseShadowRadius = 7
                }
                
                if event.socioPoliticalInstability2 > 0 {
                    gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius = 7
                } else if event.socioPoliticalInstability2 < 0 {
                    gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius = 7
                }
            }
        }
    }
    
    // Overlay view to show the indicator's value
    private func overlayView(for indicator: Int) -> some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundStyle(Color(UIColor.systemRed))
                .frame(height: CGFloat(indicator) / 12 * geometry.size.height)
                .frame(maxHeight: geometry.size.height, alignment: .bottom)
        }
    }

    // Indicator view with an added percentage
    private func indicatorView(for indicator: Int, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: getWidth() * 0.08, height: getHeight() * 0.04)
                .foregroundStyle(Color(UIColor.systemGray))
        }
    }
}
