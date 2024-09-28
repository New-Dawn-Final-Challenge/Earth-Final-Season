//
//  AudienceIndicatorView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct AudienceIndicatorView: View {
    let percentage: Int
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    init(percentage: Int) {
        self.percentage = percentage
    }
    
    var body: some View {
        VStack {
            Image(systemName: "hands.and.sparkles.fill")
                .resizable()
                .frame(width: screenWidth * 0.08,
                       height: screenHeight * 0.04)
                .foregroundStyle(Color(UIColor.systemOrange))

            ZStack(alignment: .bottom) {
                // Background Bar (empty part)
                Rectangle()
                    .fill(Color(UIColor.systemGray5))
                    .frame(width: screenWidth * 0.1,
                           height: screenHeight * 0.1)

                // Filled Bar (based on percentage)
                Rectangle()
                    .fill(Color(UIColor.systemOrange))
                    .frame(width: screenWidth * 0.1,
                           height: CGFloat(percentage) / 200 * screenHeight * 0.1)
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
