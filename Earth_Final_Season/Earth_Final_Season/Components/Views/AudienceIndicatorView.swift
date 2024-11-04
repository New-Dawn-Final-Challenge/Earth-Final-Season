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
                .frame(width: getWidth() * AudienceIndicatorConstants.imageWidthMultiplier,
                       height: getHeight() * AudienceIndicatorConstants.imageHeightMultiplier)
                .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)

            ZStack(alignment: .bottom) {
                // Background Bar (empty part)
                Rectangle()
                    .fill(Assets.Colors.accentPrimary.swiftUIColor)
                    .frame(width: getWidth() * AudienceIndicatorConstants.barWidthMultiplier,
                           height: getHeight() * AudienceIndicatorConstants.barHeightMultiplier)

                // Filled Bar (based on percentage, scaled so 3 is 0% and 11 is 100%)
                Rectangle()
                    .fill(Assets.Colors.secondaryGreen.swiftUIColor)
                    .frame(width: getWidth() * AudienceIndicatorConstants.barWidthMultiplier,
                           height: max(0, CGFloat(percentage - AudienceIndicatorConstants.percentageOffset) / AudienceIndicatorConstants.percentageScaleFactor * (getHeight() * AudienceIndicatorConstants.barHeightMultiplier)))
            }
            .cornerRadius(GlobalConstants.cornerRadius)
        }
    }
}
