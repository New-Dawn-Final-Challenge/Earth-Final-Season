//
//  ChoicesView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct ChoicesView: View {
    var shadowRadius: Int
    var text: String
    var image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: getWidth() * 0.8,
                   height: getHeight() * 0.12)
            .padding()
            .shadow(color: Color.pink, radius: CGFloat(shadowRadius))
            .overlay(
                Text(text)
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .padding(.horizontal, 50)
            )
    }
}
