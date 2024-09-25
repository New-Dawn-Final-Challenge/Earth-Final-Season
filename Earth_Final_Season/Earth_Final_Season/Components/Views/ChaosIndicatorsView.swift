//
//  ChaosIndicatorsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChaosIndicatorsView: View {
    let socialInstability: Int;
    let politicalInstability: Int;
    let environmentalDegradation: Int;
    let Year: String;
    
    init(socialInstability: Int, politicalInstability: Int, environmentalDegradation: Int, Year: String) {
        self.socialInstability = socialInstability
        self.politicalInstability = politicalInstability
        self.environmentalDegradation = environmentalDegradation
        self.Year = Year
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Year: \(Year)")
                .font(.title2)
                .fontWeight(.bold)
            HStack(spacing: 60) {
                // Social Instability Button
                Button(action: {
                    // Action for social instability
                }) {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 30, height: 30)
                        Text("\(socialInstability)")
                            .font(.system(size: 25))
                    }
                }
                
                // Political Instability Button
                Button(action: {
                    // Action for political instability
                }) {
                    VStack {
                        Image(systemName: "building.2.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 30, height: 30)
                        Text("\(politicalInstability)")
                            .font(.system(size: 25))
                    }
                }
                
                // Environmental Degradation Button
                Button(action: {
                    // Action for environmental degradation
                }) {
                    VStack {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 30, height: 30)
                        Text("\(environmentalDegradation)")
                            .font(.system(size: 25))
                    }
                }
            }
        }
        .frame(width: 250, height: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    ChaosIndicatorsView(socialInstability: 0, politicalInstability: 0, environmentalDegradation: 0, Year: "2070")
}
