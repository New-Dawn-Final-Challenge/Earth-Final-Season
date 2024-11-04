//
//  SettingsButtonView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI
import Design_System

struct SettingsButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
            .frame(width: getWidth() * ButtonViewConstants.frameWidthMultiplier,
                   height: getHeight() * ButtonViewConstants.frameHeightMultiplier)
            .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)
            .overlay(
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            )
    }
}

#Preview {
    SettingsButtonView()
}
