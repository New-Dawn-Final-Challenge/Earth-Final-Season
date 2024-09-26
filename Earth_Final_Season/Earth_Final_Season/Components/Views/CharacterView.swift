//
//  CharacterView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct CharacterView: View {
    let characterImage: String;
    let characterName: String;
    
    init(characterImage: String, characterName: String) {
        self.characterImage = characterImage
        self.characterName = characterName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image rectangle
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 150)
                .overlay(
                    Image(characterImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 80, height: 80)
                        .foregroundColor(.accentColor)
                )
            
            // Name rectangle
            Rectangle()
                .fill(Color.blue.opacity(0.8))
                .frame(width: 150, height: 50)
                .overlay(
                    Text(characterName)
                        .foregroundColor(.white)
                        .font(.headline)
                )
        }
        .cornerRadius(10) // Add rounding to both rectangles
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}
