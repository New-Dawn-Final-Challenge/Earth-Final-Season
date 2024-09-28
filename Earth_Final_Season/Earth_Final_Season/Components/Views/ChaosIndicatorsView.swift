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
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    init(socialInstability: Int, politicalInstability: Int, environmentalDegradation: Int, year: String) {
        self.socialInstability = socialInstability
        self.politicalInstability = politicalInstability
        self.environmentalDegradation = environmentalDegradation
        self.year = year
    }
    
    var body: some View {
        VStack {
            Text("Year: \(year)").bold()
            
            HStack(spacing: 30) {
                // Environmental Degradation indicator with overlay
                indicatorView(image: "leaf.fill", percentage: environmentalDegradation)
                    .overlay(
                        overlayView(for: environmentalDegradation)
                            .mask(indicatorView(image: "leaf.fill", percentage: environmentalDegradation))
                    )
                
                // Political Instability indicator with overlay
                indicatorView(image: "person.fill", percentage: politicalInstability)
                    .overlay(
                        overlayView(for: politicalInstability)
                            .mask(indicatorView(image: "person.fill", percentage: politicalInstability))
                    )
                
                // Social Instability indicator with overlay
                indicatorView(image: "building.2.crop.circle.fill", percentage: socialInstability)
                    .overlay(
                        overlayView(for: socialInstability)
                            .mask(indicatorView(image: "building.2.crop.circle.fill", percentage: socialInstability))
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
            .frame(width: screenWidth * 0.1, height: screenHeight * 0.05)
            .foregroundStyle(Color(UIColor.systemGray))
    }
}

//#Preview {
//    ChaosIndicatorsView(socialInstability: 0,
//                        politicalInstability: 0,
//                        environmentalDegradation: 0,
//                        year: "2070")
//}
