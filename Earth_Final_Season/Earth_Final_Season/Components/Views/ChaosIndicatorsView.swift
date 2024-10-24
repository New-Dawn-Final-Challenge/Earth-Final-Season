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
        VStack {
            Text("Year: \(year)")
                .font(.bodyFont)
                .bold()
            
            HStack(spacing: getWidth() * 0.1) {
                // Environmental Degradation indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(indicator: "environmentalDegradation", nIndicator: 0)
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.08,
                           height: UIScreen.main.bounds.height * 0.04)
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
                        Image(systemName: "leaf.fill")
                            .resizable()
                    )
                    .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.environmentalDegradationDecreaseShadowRadius))
                    .shadow(color: Color.orange, radius: CGFloat(gameplayVM.environmentalDegradationIncreaseShadowRadius))
                    .shadow(color: Color.purple, radius: CGFloat(gameplayVM.environmentalDegradationShadowRadius))
                }

                // Ill-being indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(indicator: "illBeing", nIndicator: 1)
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.08,
                           height: UIScreen.main.bounds.height * 0.04)
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
                        Image(systemName: "person.fill")
                            .resizable()
                    )
                    .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.illBeingDecreaseShadowRadius))
                    .shadow(color: Color.orange, radius: CGFloat(gameplayVM.illBeingIncreaseShadowRadius))
                    .shadow(color: Color.purple, radius: CGFloat(gameplayVM.illBeingShadowRadius))
                }

                // Sociopolitical Instability with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(indicator: "socioPoliticalInstability", nIndicator: 2)
                        .frame(width: getWidth() * 0.15, height: getHeight() * 0.01)
                    Image(systemName: "building.2.crop.circle.fill")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.08,
                           height: UIScreen.main.bounds.height * 0.04)
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
                        Image(systemName: "building.2.crop.circle.fill")
                            .resizable()
                    )
                    .shadow(color: Color.cyan, radius: CGFloat(gameplayVM.sociopoliticalInstabilityDecreaseShadowRadius))
                    .shadow(color: Color.orange, radius: CGFloat(gameplayVM.sociopoliticalInstabilityIncreaseShadowRadius))
                    .shadow(color: Color.purple, radius: CGFloat(gameplayVM.sociopoliticalInstabilityShadowRadius))
                }
            }
        }
        .padding()
        .background(
            Assets.Images.indicatorsScreen.swiftUIImage
                .resizable()
                .scaledToFit()
        )
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
