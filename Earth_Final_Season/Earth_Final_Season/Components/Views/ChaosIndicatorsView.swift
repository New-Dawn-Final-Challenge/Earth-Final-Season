//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChaosIndicatorsView: View {
    let illBeing: Int
    let socioPoliticalInstability: Int
    let environmentalDegradation: Int
    let year: String
    
    @Binding var viewModel: GameplayViewModel
    
    var body: some View {
        VStack {
            Text("Year: \(year)")
                .font(.system(size: 16))
                .bold()
                .padding(.bottom, 10)
            
            HStack(spacing: getWidth() * 0.2) {
                // Environmental Degradation indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(viewModel: $viewModel, indicator: "environmentalDegradation")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(for: environmentalDegradation, image: "leaf.fill")
                        .overlay(
                            overlayView(for: environmentalDegradation)
                                .mask(indicatorView(for: environmentalDegradation, image: "leaf.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(viewModel.environmentalDegradationDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(viewModel.environmentalDegradationIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(viewModel.environmentalDegradationShadowRadius))
                }

                // Sociopolitical Instability indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(viewModel: $viewModel, indicator: "illBeing")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(for: socioPoliticalInstability, image: "person.fill")
                        .overlay(
                            overlayView(for: socioPoliticalInstability)
                                .mask(indicatorView(for: socioPoliticalInstability, image: "person.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(viewModel.illBeingDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(viewModel.illBeingIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(viewModel.illBeingShadowRadius))
                }

                // Ill-Being indicator with overlay
                VStack {
                    ChaosIndicatorsValueChangeView(viewModel: $viewModel, indicator: "sociopoliticalInstability")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(for: illBeing, image: "building.2.crop.circle.fill")
                        .overlay(
                            overlayView(for: illBeing)
                                .mask(indicatorView(for: illBeing, image: "building.2.crop.circle.fill"))
                        )
                        .shadow(color: Color.cyan, radius: CGFloat(viewModel.sociopoliticalInstabilityDecreaseShadowRadius))
                        .shadow(color: Color.orange, radius: CGFloat(viewModel.sociopoliticalInstabilityIncreaseShadowRadius))
                        .shadow(color: Color.purple, radius: CGFloat(viewModel.sociopoliticalInstabilityShadowRadius))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(UIColor.systemGray4))
        )
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
