//
//  AudienceIndicatorView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//
import SwiftUI
import Design_System

struct AudienceIndicatorView: View {
    let percentage: CGFloat
    
    init(percentage: CGFloat) {
        self.percentage = percentage
    }
    
    var body: some View {
        VStack {
            Image(systemName: "hands.and.sparkles.fill")
                .resizable()
                .frame(width: getWidth() * Constants.AudienceIndicator.imageWidthMultiplier,
                       height: getHeight() * Constants.AudienceIndicator.imageHeightMultiplier)
                .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)

            ZStack(alignment: .bottom) {
                // Background Bar (empty part)
                Rectangle()
                    .fill(Assets.Colors.accentPrimary.swiftUIColor)
                    .frame(width: getWidth() * Constants.AudienceIndicator.barWidthMultiplier,
                           height: getHeight() * Constants.AudienceIndicator.barHeightMultiplier)

                // Filled Bar (based on percentage, scaled so 3 is 0% and 11 is 100%)
                Rectangle()
                    .fill(Assets.Colors.secondaryGreen.swiftUIColor)
                    .frame(width: getWidth() * Constants.AudienceIndicator.barWidthMultiplier,
                           height: max(0, CGFloat(percentage - Constants.AudienceIndicator.percentageOffset) / Constants.AudienceIndicator.percentageScaleFactor * (getHeight() * Constants.AudienceIndicator.barHeightMultiplier)))
            }
            .cornerRadius(Constants.Global.cornerRadius)
        }
    }
}
