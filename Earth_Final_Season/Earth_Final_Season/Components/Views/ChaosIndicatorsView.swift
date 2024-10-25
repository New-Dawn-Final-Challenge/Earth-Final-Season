//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct ChaosIndicatorsView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    let illBeing: Int
    let socioPoliticalInstability: Int
    let environmentalDegradation: Int
    let year: String
    
    var body: some View {
        ZStack {
            Assets.Images.indicatorsScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.6,
                       height: getHeight() * 0.145)
            
            VStack {
                Text("Year: \(year)")
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .bold()
                
                HStack(spacing: 12) {
                    // Environmental Degradation indicator with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "environmentalDegradation", nIndicator: 0)
                            .frame(width: getWidth() * 0.1, height: getHeight() * 0.01)
                        Assets.Images.environmentalDegradationSimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * 0.14,
                                   height: getHeight() * 0.05)
                            .foregroundStyle(Color(UIColor.systemGray))
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                        .foregroundStyle(Color(UIColor.systemRed))
                                        .frame(height: CGFloat(environmentalDegradation) / 12 * geometry.size.height)
                                        .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.environmentalDegradationSimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius))
                            .shadow(color: Color.orange, radius: CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius))
                            .shadow(color: Color.purple, radius: CGFloat(gameplayVM.environmentalDegradationShadowRadius))
                    }

                    // Ill-being indicator with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "illBeing", nIndicator: 1)
                            .frame(width: getWidth() * 0.1, height: getHeight() * 0.01)
                        Assets.Images.illbeingSimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * 0.14,
                                   height: getHeight() * 0.05)
                            .foregroundStyle(Color(UIColor.systemGray))
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                    .foregroundStyle(Color(UIColor.systemRed))
                                    .frame(height: CGFloat(illBeing) / 12 * geometry.size.height)
                                    .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.illbeingSimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.illBeingDecreaseShadowRadius))
                            .shadow(color: Color.orange, radius: CGFloat(gameplayVM.illBeingIncreaseShadowRadius))
                            .shadow(color: Color.purple, radius: CGFloat(gameplayVM.illBeingShadowRadius))
                    }

                    // Sociopolitical Instability with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "socioPoliticalInstability", nIndicator: 2)
                            .frame(width: getWidth() * 0.1, height: getHeight() * 0.01)
                        Assets.Images.sociopoliticalInstabilitySimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * 0.14,
                                   height: getHeight() * 0.05)
                            .foregroundStyle(Color(UIColor.systemGray))
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                    .foregroundStyle(Color(UIColor.systemRed))
                                    .frame(height: CGFloat(socioPoliticalInstability) / 12 * geometry.size.height)
                                    .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.sociopoliticalInstabilitySimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius))
                            .shadow(color: Color.orange, radius: CGFloat(gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius))
                            .shadow(color: Color.purple, radius: CGFloat(gameplayVM.sociopoliticalInstabilityShadowRadius))
                    }
                }
            }
        }
        .padding()
        .onChange(of: gameplayVM.currentState) {
            if gameplayVM.currentState == .consequence {
                withAnimation(Animation.linear(duration: 1).repeatCount(3, autoreverses: true)) {
                    gameplayVM.animateIndicatorsChange()
                }
            } else {
                withAnimation(Animation.linear(duration: 1)) {
                    gameplayVM.animateIndicatorsChange()
                }
            }
        }
    }
}
