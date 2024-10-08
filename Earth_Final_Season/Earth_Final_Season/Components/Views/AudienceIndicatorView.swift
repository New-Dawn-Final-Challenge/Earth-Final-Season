//
//  AudienceIndicatorView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

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
                .foregroundStyle(Color(UIColor.systemOrange))

            ZStack(alignment: .bottom) {
                // Background Bar (empty part)
                Rectangle()
                    .fill(Color(UIColor.systemGray5))
                    .frame(width: getWidth() * 0.094,
                           height: getHeight() * 0.087)

                // Filled Bar (based on percentage)
                Rectangle()
                    .fill(Color(UIColor.systemOrange))
                    .frame(width: getWidth() * 0.094,
                           height: CGFloat(percentage) / 10 * (getHeight() * 0.087))
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
