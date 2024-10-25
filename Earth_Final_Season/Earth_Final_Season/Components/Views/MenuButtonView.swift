//
//  MenuButtonView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 18/10/24.
//

import SwiftUI
import Design_System

struct MenuButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: getWidth() * 0.1,
                   height: getHeight() * 0.05)
            .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)
            .overlay(
                Image(systemName: "house.fill")
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            )
    }
}

#Preview {
    MenuButtonView()
}
