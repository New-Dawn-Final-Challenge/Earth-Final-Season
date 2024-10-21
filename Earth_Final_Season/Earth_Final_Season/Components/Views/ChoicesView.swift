//
//  ChoicesView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChoicesView: View {
    var shadowRadius: Int
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: getWidth() * 0.8,
                   height: getHeight() * 0.08)
            .foregroundStyle(Color(UIColor.systemGray4))
            .padding()
            .shadow(color: Color.pink, radius: CGFloat(shadowRadius))
            .overlay(
                Text(text)
                    .font(.bodyFont)
                    .padding(.horizontal, 30)
            )
    }
}
