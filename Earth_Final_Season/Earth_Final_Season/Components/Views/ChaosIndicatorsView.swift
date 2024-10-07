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
    
    init(illBeing: Int, socioPoliticalInstability: Int, environmentalDegradation: Int, year: String) {
        self.illBeing = illBeing
        self.socioPoliticalInstability = socioPoliticalInstability
        self.environmentalDegradation = environmentalDegradation
        self.year = year
    }
    
    var body: some View {
        VStack {
            Text("Year: \(year)")
                .font(.system(size: 16))
                .bold()
                .padding(.bottom, 10)
            
            HStack(spacing: getWidth() * 0.2) {
                // Environmental Degradation indicator with overlay
                indicatorView(for: environmentalDegradation, image: "leaf.fill")
                    .overlay(
                        overlayView(for: environmentalDegradation)
                            .mask(indicatorView(for: environmentalDegradation, image: "leaf.fill"))
                    )

                // Sociopolitical Instability indicator with overlay
                indicatorView(for: socioPoliticalInstability, image: "person.fill")
                    .overlay(
                        overlayView(for: socioPoliticalInstability)
                            .mask(indicatorView(for: socioPoliticalInstability, image: "person.fill"))
                    )

                // Ill-Being indicator with overlay
                indicatorView(for: illBeing, image: "building.2.crop.circle.fill")
                    .overlay(
                        overlayView(for: illBeing)
                            .mask(indicatorView(for: illBeing, image: "building.2.crop.circle.fill"))
                    )
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
