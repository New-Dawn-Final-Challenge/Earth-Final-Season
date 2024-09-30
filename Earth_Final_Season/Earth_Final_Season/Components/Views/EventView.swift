//
//  EventView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//
import SwiftUI

struct EventView: View {
    @Binding var mainScreenShadowRadius: Int
    
    let eventDescription: String
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: screenWidth * 0.8,
                   height: screenHeight * 0.15)
            .padding()
            .foregroundStyle(Color(UIColor.systemGray4))
            .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
            .overlay(
                Text(eventDescription)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding()
            )
    }
}
