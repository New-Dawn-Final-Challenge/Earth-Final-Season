//
//  MenuButtonView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 09/11/24.
//

import SwiftUI
import Design_System

struct MenuButtonView<Destination: View>: View {
    var destination: Destination
    var label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                       height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .foregroundColor(Color.white)
                .cornerRadius(Constants.MenuView.buttonCornerRadius)
                .overlay(
                   RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                    .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
               )
        }
    }
}
