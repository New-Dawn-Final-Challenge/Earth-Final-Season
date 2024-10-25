//
//  AudienceIndicatorView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct AudienceIndicatorView: View {
    let percentage: Int
    
    init(percentage: Int) {
        self.percentage = percentage
    }
    
    var body: some View {
        VStack {
            Image(systemName: "hands.and.sparkles.fill")
                .resizable()
                .frame(width: getWidth() * 0.084,
                       height: getHeight() * 0.042)
                .foregroundStyle(Assets.Colors.secondaryGreenVariation.swiftUIColor)

            ZStack(alignment: .bottom) {
                // Background Bar (empty part)
                Rectangle()
                    .fill(Assets.Colors.accentPrimary.swiftUIColor)
                    .frame(width: getWidth() * 0.094,
                           height: getHeight() * 0.087)

                // Filled Bar (based on percentage, scaled so 3 is 0% and 11 is 100%)
                Rectangle()
                    .fill(Assets.Colors.secondaryGreen.swiftUIColor)
                    .frame(width: getWidth() * 0.094,
                           height: max(0, CGFloat(percentage - 3) / 8 * (getHeight() * 0.087)))
            }
            .cornerRadius(16)
        }
    }
}

struct AudienceIndicatorView_Preview: PreviewProvider {
    static var previews: some View {
        AudienceIndicatorView(percentage: 50)
    }
}
