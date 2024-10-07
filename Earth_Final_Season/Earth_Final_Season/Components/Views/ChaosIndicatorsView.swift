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
    
    init(socialInstability: Int, politicalInstability: Int, environmentalDegradation: Int, year: String) {
        self.socialInstability = socialInstability
        self.politicalInstability = politicalInstability
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
                
                VStack {
                    // Environmental Degradation indicator with overlay
                    indicatorView(for: environmentalDegradation, image: "leaf.fill")
                        .overlay(
                            overlayView(for: environmentalDegradation)
                                .mask(indicatorView(for: environmentalDegradation, image: "leaf.fill"))
                        )
                    
                    Text("\(environmentalDegradation)")

                    Text("\(String(format: "%.0f", (Double(environmentalDegradation) / 12) * 100))%")
                }
                
                VStack {
                    // Political Instability indicator with overlay
                    indicatorView(for: politicalInstability, image: "person.fill")
                        .overlay(
                            overlayView(for: politicalInstability)
                                .mask(indicatorView(for: politicalInstability, image: "person.fill"))
                        )
                    
                    Text("\(politicalInstability)")

                    Text("\(String(format: "%.0f", (Double(politicalInstability) / 12) * 100))%")
                }
                
                VStack {
                    // Social Instability indicator with overlay
                    indicatorView(for: socialInstability, image: "building.2.crop.circle.fill")
                        .overlay(
                            overlayView(for: socialInstability)
                                .mask(indicatorView(for: socialInstability, image: "building.2.crop.circle.fill"))
                        )
                    
                    Text("\(socialInstability)")

                    Text("\(String(format: "%.0f", (Double(socialInstability) / 12) * 100))%")
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
