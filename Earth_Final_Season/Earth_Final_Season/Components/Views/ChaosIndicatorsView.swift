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
                .frame(width: getWidth() * Constants.ChaosIndicators.indicatorFrameWidthMultiplier,
                       height: getHeight() * Constants.ChaosIndicators.indicatorFrameHeightMultiplier)
            
            VStack {
                Text("Year: \(year)")
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .bold()
                
                HStack(spacing: Constants.ChaosIndicators.hStackSpacing) {
                    ForEach(indicatorData, id: \.indicator) { data in
                        indicatorView(
                            indicator: data.indicator,
                            value: data.value,
                            decreaseSR: data.decreaseSR,
                            increaseSR: data.increaseSR,
                            neutralSR: data.neutralSR
                        )
                    }
                }
            }
        }
        .padding()
        .onChange(of: gameplayVM.currentState) {
            if gameplayVM.currentState == .consequence {
                withAnimation(Animation.linear(duration: Constants.ChaosIndicators.animationDuration).repeatCount(Constants.ChaosIndicators.animationRepeatCount, autoreverses: true)) {
                    gameplayVM.animateIndicatorsChange()
                }
            } else {
                withAnimation(Animation.linear(duration: Constants.ChaosIndicators.animationDuration)) {
                    gameplayVM.animateIndicatorsChange()
                }
            }
        }
    }
    
    // Helper function to generate each indicator view
    @ViewBuilder
    private func indicatorView(indicator: String, value: Int,
                               decreaseSR: CGFloat, increaseSR: CGFloat, neutralSR: CGFloat) -> some View {
        VStack {
            ChaosIndicatorsValueChangeView(indicator: indicator, nIndicator: nIndicator(for: indicator))
                .frame(width: getWidth() * Constants.ChaosIndicators.changeViewWidthMultiplier,
                       height: getHeight() * Constants.ChaosIndicators.changeViewHeightMultiplier)
            imageForIndicator(indicator)
                .resizable()
                .frame(width: getWidth() * Constants.ChaosIndicators.frameWidthMultiplier,
                       height: getHeight() * Constants.ChaosIndicators.frameHeightMultiplier)
                .colorInvert()
                .colorMultiply(Assets.Colors.bgFillPrimary.swiftUIColor)
                .overlay(
                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundStyle(Assets.Colors.secondaryOrange.swiftUIColor)
                            .frame(height: CGFloat(value) / Constants.ChaosIndicators.hStackSpacing * geometry.size.height)
                            .frame(maxHeight: geometry.size.height, alignment: .bottom)
                    }
                )
                .mask(imageForIndicator(indicator).resizable())
                .shadow(color: Assets.Colors.secondaryBlue.swiftUIColor,
                        radius: decreaseSR)
                .shadow(color: Assets.Colors.secondaryPurpleVariation.swiftUIColor,
                        radius: increaseSR)
                .shadow(color: Assets.Colors.secondaryGreen.swiftUIColor, radius: neutralSR)
        }
    }

    private func imageForIndicator(_ indicator: String) -> Image {
        switch indicator {
        case "environmentalDegradation":
            return Assets.Images.environmentalDegradationSimple.swiftUIImage
        case "illBeing":
            return Assets.Images.illbeingSimple.swiftUIImage
        case "socioPoliticalInstability":
            return Assets.Images.sociopoliticalInstabilitySimple.swiftUIImage
        default:
            return Image(systemName: "questionmark")
        }
    }

    private func nIndicator(for indicator: String) -> Int {
        switch indicator {
        case "environmentalDegradation": return 0
        case "illBeing": return 1
        case "socioPoliticalInstability": return 2
        default: return -1
        }
    }

    private var indicatorData: [(indicator: String, value: Int,
                                 decreaseSR: CGFloat, increaseSR: CGFloat, neutralSR: CGFloat)] {
        [
            ("environmentalDegradation", environmentalDegradation,
             CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius),
             CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius),
             CGFloat(gameplayVM.environmentalDegradationShadowRadius)),
            ("illBeing", illBeing,
             CGFloat(gameplayVM.illBeingDecreaseShadowRadius),
             CGFloat(gameplayVM.illBeingIncreaseShadowRadius),
             CGFloat(gameplayVM.illBeingShadowRadius)),
            ("socioPoliticalInstability", socioPoliticalInstability,
             CGFloat(gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius),
             CGFloat(gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius),
             CGFloat(gameplayVM.sociopoliticalInstabilityShadowRadius))
        ]
    }
}
