//
//  HelpButtonView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI
import Design_System

struct HelpButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .frame(width: getWidth() * Constants.ButtonView.frameWidthMultiplier,
                   height: getHeight() * Constants.ButtonView.frameHeightMultiplier)
            .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)
            .overlay(
                Image(systemName: "questionmark")
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            )
    }
}

#Preview {
    HelpButtonView()
}

