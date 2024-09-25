//
//  AudienceIndicatorView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI


struct AudienceIndicatorView: View {
    
    let percentage: Int;
    
    init(percentage: Int) {
        self.percentage = percentage
    }
    
    
    var body: some View {
        VStack{
            Image(systemName: "hands.and.sparkles.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.accentColor)
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    // Background Bar (empty part)
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40) // Set the width for the bar
                    
                    // Filled Bar (based on percentage)
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: 40, height: CGFloat(percentage) / 100 * geometry.size.height)
                }
                .cornerRadius(16)
            }
            .frame(width: 40, height: 90) // Set a fixed width for the bar
        }
    }
}

struct AudienceIndicatorView_Preview: PreviewProvider {
    static var previews: some View {
        AudienceIndicatorView(percentage: 90)
    }
}
