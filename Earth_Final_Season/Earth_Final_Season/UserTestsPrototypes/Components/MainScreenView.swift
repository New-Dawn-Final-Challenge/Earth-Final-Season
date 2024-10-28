//
//  MainScreenView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 27/09/24.
//

import SwiftUI

struct MainScreenView: View {
    @Binding var optionToChoose: String
    @Binding var mainScreenShadowRadius: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: getWidth() * 0.8,
                   height: getHeight() * 0.2)
            .foregroundStyle(Color(UIColor.systemGray4))
            .padding()
            .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
            .overlay(
                Text(optionToChoose)
                    .font(.bodyFont)
            )
    }
}
