//
//  ConfigurationButtonView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI

struct ConfigurationButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: UIScreen.main.bounds.width * 0.1,
                   height: UIScreen.main.bounds.height * 0.05)
            .foregroundStyle(Color(UIColor.systemPurple))
            .overlay(
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(.black)
            )
    }
}

#Preview {
    ConfigurationButtonView()
}
