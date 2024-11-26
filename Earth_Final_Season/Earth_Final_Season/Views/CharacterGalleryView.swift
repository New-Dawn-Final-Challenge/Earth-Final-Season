//
//  CharacterGalleryView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 26/11/24.
//

import SwiftUI
import Design_System

struct CharacterGalleryView: View {
    var body: some View {
        ZStack {
            popUpBackground
            
            VStack {
                title
                charactersUnlocked
            }
            .padding()
        }
        .padding()
        .background(Color.black.opacity(0.6))
    }
    
    private var popUpBackground: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: Constants.Global.lineWidth)
            .background(
                RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                    .foregroundStyle(Color.black)
            )
    }
    
    private var title: some View {
        Text3dEffect(text: "Character Gallery")
            .font(.largeTitleFont)
    }
    
    private var charactersUnlocked: some View {
        Text("Characters unlocked: 8/14")
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .font(.bodyFont)
    }
}

#Preview {
    CharacterGalleryView()
}
