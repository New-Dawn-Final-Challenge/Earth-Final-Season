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
            .frame(width: getWidth() * ChoicesViewConstants.imageFrameWidthMultiplier,
                   height: getHeight() * ChoicesViewConstants.imageFrameHeightMultiplier)
            .padding()
            .shadow(color: shadowRadius == 0 ?
                    Color.clear : Assets.Colors.secondaryGreen.swiftUIColor,
                    radius: CGFloat(shadowRadius))
            .overlay(
                Text(text)
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .padding(.horizontal, ChoicesViewConstants.horizontalPadding)
            )
    }
}
