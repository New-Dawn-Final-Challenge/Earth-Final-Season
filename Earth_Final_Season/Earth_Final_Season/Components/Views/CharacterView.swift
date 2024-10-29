//
//  CharacterView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct CharacterView: View {
    let characterImage: String
    let characterName: String
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    init(characterImage: String, characterName: String) {
        self.characterImage = characterImage
        self.characterName = characterName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image rectangle
             Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.5,
                       height: getHeight() * 0.18)
                .overlay(
                    VStack() {
                        GlitchContentView()
                            .frame(width: getWidth() * 0.28,
                                   height: getHeight() * 0.10)
                            .cornerRadius(16)
                        Spacer()
                        
                        Text(characterName)
                            .font(.bodyFont)
                            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                            .bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: 20)
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal)
                )
        }
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}
