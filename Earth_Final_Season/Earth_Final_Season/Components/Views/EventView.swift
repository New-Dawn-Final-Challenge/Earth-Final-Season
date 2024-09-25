//
//  EventView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//
import SwiftUI

struct EventView: View {
    
    let eventDescription: String
    
    init(eventDescription: String) {
        self.eventDescription = eventDescription
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image rectangle
            Rectangle()
                .fill(Color.blue.opacity(0.8))
                .frame(width: 340, height: 180)
                .overlay(
                    Text(eventDescription)
                        .foregroundColor(.white)
                        .font(.title)
                )
        }
        .cornerRadius(10) // Add rounding to both rectangles
    }
}

#Preview {
    EventView(eventDescription: "Event")
}

