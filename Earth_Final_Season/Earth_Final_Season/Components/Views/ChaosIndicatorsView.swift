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
                .frame(width: getWidth() * ChaosIndicatorsConstants.indicatorFrameWidthMultiplier,
                       height: getHeight() * ChaosIndicatorsConstants.indicatorFrameHeightMultiplier)
            
            VStack {
                Text("Year: \(year)")
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .bold()
                
                HStack(spacing: ChaosIndicatorsConstants.hStackSpacing) {
                    // Environmental Degradation indicator with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "environmentalDegradation", nIndicator: 0)
                            .frame(width: getWidth() * ChaosIndicatorsConstants.changeViewWidthMultiplier, height: getHeight() * ChaosIndicatorsConstants.changeViewHeightMultiplier)
                        Assets.Images.environmentalDegradationSimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * ChaosIndicatorsConstants.frameWidthMultiplier,
                                   height: getHeight() * ChaosIndicatorsConstants.frameHeightMultiplier)
                            .colorInvert().colorMultiply(Assets.Colors.bgFillPrimary.swiftUIColor)
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                        .foregroundStyle(Assets.Colors.secondaryOrange.swiftUIColor)
                                        .frame(height: CGFloat(environmentalDegradation) / ChaosIndicatorsConstants.hStackSpacing * geometry.size.height)
                                        .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.environmentalDegradationSimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Assets.Colors.secondaryBlue.swiftUIColor,
                                    radius: CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryPurpleVariation.swiftUIColor,
                                    radius: CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryGreen.swiftUIColor,
                                    radius: CGFloat(gameplayVM.environmentalDegradationShadowRadius))
                    }

                    // Ill-being indicator with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "illBeing", nIndicator: 1)
                            .frame(width: getWidth() * ChaosIndicatorsConstants.changeViewWidthMultiplier, height: getHeight() * ChaosIndicatorsConstants.changeViewHeightMultiplier)
                        Assets.Images.illbeingSimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * ChaosIndicatorsConstants.frameWidthMultiplier,
                                   height: getHeight() * ChaosIndicatorsConstants.frameHeightMultiplier)
                            .colorInvert().colorMultiply(Assets.Colors.bgFillPrimary.swiftUIColor)
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                    .foregroundStyle(Assets.Colors.secondaryOrange.swiftUIColor)
                                    .frame(height: CGFloat(illBeing) / ChaosIndicatorsConstants.hStackSpacing * geometry.size.height)
                                    .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.illbeingSimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Assets.Colors.secondaryBlue.swiftUIColor,
                                    radius: CGFloat(gameplayVM.illBeingDecreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryPurpleVariation.swiftUIColor,
                                    radius: CGFloat(gameplayVM.illBeingIncreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryGreen.swiftUIColor,
                                    radius: CGFloat(gameplayVM.illBeingShadowRadius))
                    }

                    // Sociopolitical Instability with overlay
                    VStack {
                        ChaosIndicatorsValueChangeView(indicator: "socioPoliticalInstability", nIndicator: 2)
                            .frame(width: getWidth() * ChaosIndicatorsConstants.changeViewWidthMultiplier, height: getHeight() * ChaosIndicatorsConstants.changeViewHeightMultiplier)
                        Assets.Images.sociopoliticalInstabilitySimple.swiftUIImage
                            .resizable()
                            .frame(width: getWidth() * ChaosIndicatorsConstants.frameWidthMultiplier,
                                   height: getHeight() * ChaosIndicatorsConstants.frameHeightMultiplier)
                            .colorInvert().colorMultiply(Assets.Colors.bgFillPrimary.swiftUIColor)
                            .overlay(
                                GeometryReader { geometry in
                                    Rectangle()
                                    .foregroundStyle(Assets.Colors.secondaryOrange.swiftUIColor)
                                    .frame(height: CGFloat(socioPoliticalInstability) / ChaosIndicatorsConstants.hStackSpacing * geometry.size.height)
                                    .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                }
                            )
                            .mask(
                                Assets.Images.sociopoliticalInstabilitySimple.swiftUIImage
                                    .resizable()
                            )
                            .shadow(color: Assets.Colors.secondaryBlue.swiftUIColor,
                                    radius: CGFloat(gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryPurpleVariation.swiftUIColor,
                                    radius: CGFloat(gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius))
                            .shadow(color: Assets.Colors.secondaryGreen.swiftUIColor,
                                    radius: CGFloat(gameplayVM.sociopoliticalInstabilityShadowRadius))
                    }
                }
            }
        }
        .padding()
        .onChange(of: gameplayVM.currentState) {
            if gameplayVM.currentState == .consequence {
                withAnimation(Animation.linear(duration: ChaosIndicatorsConstants.animationDuration).repeatCount(ChaosIndicatorsConstants.animationRepeatCount, autoreverses: true)) {
                    gameplayVM.animateIndicatorsChange()
                }
            } else {
                withAnimation(Animation.linear(duration: ChaosIndicatorsConstants.animationDuration)) {
                    gameplayVM.animateIndicatorsChange()
                }
            }
        }
    }
}
