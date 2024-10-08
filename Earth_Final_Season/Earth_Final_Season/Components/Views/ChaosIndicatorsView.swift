//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChaosIndicatorsView: View {
    let socialInstability: Int
    let politicalInstability: Int
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
                VStack() {
                    ChaosIndicatorsValueChangeView(viewModel: viewModel, indicator: "environmentalDegradation")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(image: "leaf.fill", percentage: environmentalDegradation)
                        .overlay(
                            overlayView(for: environmentalDegradation)
                                .mask(indicatorView(image: "leaf.fill", percentage: environmentalDegradation))
                        )
                        .shadow(color: Color.purple, radius: CGFloat(viewModel.environmentalDegradationShadowRadius))
                }

                // Political Instability indicator with overlay
                VStack() {
                    ChaosIndicatorsValueChangeView(viewModel: viewModel, indicator: "illBeing")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(image: "person.fill", percentage: politicalInstability)
                        .overlay(
                            overlayView(for: politicalInstability)
                                .mask(indicatorView(image: "person.fill", percentage: politicalInstability))
                        )
                        .shadow(color: Color.purple, radius: CGFloat(viewModel.illBeingShadowRadius))
                }
                
                // Social Instability indicator with overlay
                VStack() {
                    ChaosIndicatorsValueChangeView(viewModel: viewModel, indicator: "sociopoliticalInstability")
                        .frame(height: getHeight() * 0.01)
                    indicatorView(image: "building.2.crop.circle.fill", percentage: socialInstability)
                        .overlay(
                            overlayView(for: socialInstability)
                                .mask(indicatorView(image: "building.2.crop.circle.fill", percentage: socialInstability))
                        )
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
            ZStack(alignment: .bottom) {
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .foregroundStyle(Color(UIColor.systemRed))
                        .frame(height: CGFloat(indicator) / 20 * geometry.size.height)
                }
            }
        }
    }

    // Indicator view with an added percentage
    private func indicatorView(image: String, percentage: Int) -> some View {
        Image(systemName: image)
            .resizable()
            .frame(width: getWidth() * 0.08, height: getHeight() * 0.04)
            .foregroundStyle(Color(UIColor.systemGray))
    }
}
