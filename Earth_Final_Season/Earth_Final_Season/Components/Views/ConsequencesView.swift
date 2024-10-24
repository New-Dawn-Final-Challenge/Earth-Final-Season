//
//  ConsequencesView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 02/10/24.
//

import SwiftUI

struct ConsequencesView: View {
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: getWidth() * 0.8,
                   height: getHeight() * 0.08)
            .foregroundStyle(Color(UIColor.systemGray4))
            .padding()
            .overlay(
                Text(text)
                    .font(.bodyFont)
            )
    }
}

#Preview {
    ConsequencesView(text: "")
}
