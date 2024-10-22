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
                .scaledToFit()
                .overlay(
                    VStack(spacing: 12) {
                        Image(characterImage)
                            .resizable()
                            .frame(width: getWidth() * 0.4,
                                   height: getHeight() * 0.115)
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.accentColor)
                            .cornerRadius(16)
                        
                        Text(characterName)
                            .font(.bodyFont)
                            .bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 35)
                    .padding(.horizontal, 20)
                )
        }
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}
