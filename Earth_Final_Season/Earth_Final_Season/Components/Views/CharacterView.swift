//
//  CharacterView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

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
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: screenWidth * 0.5,
                       height: screenHeight * 0.2)
                .overlay(
                    Image(characterImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 80, height: 80)
                        .foregroundColor(.accentColor)
                )
            
            // Name rectangle
            Rectangle()
                .foregroundStyle(Color(UIColor.systemGray4))
                .frame(width: screenWidth * 0.5,
                       height: screenHeight * 0.08)
                .overlay(
                    Text(characterName)
                        .bold()
                        .multilineTextAlignment(.center)
                )
        }
        .cornerRadius(16) // Add rounding to both rectangles
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}
