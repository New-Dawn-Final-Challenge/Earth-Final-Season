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
    @State private var triggerChangeChannel: Bool = false

    init(characterImage: String, characterName: String) {
        self.characterImage = characterImage
        self.characterName = characterName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image rectangle
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.CharacterView.imageFrameWidthMultiplier,
                       height: getHeight() * Constants.CharacterView.imageFrameHeightMultiplier)
                .overlay(
                    // Change the distance between image and text
                    VStack (spacing: 7) {
                        GlitchContentView(trigger: $triggerChangeChannel)
                            .frame(width: getWidth() * Constants.CharacterView.glitchViewWidthMultiplier,
                                   height: getHeight() * Constants.CharacterView.glitchViewHeightMultiplier)
                            .cornerRadius(Constants.Global.cornerRadius)
                        
                        GlitchCharacterView(trigger: $triggerChangeChannel, characterName: characterName)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: 20)
                    }
                    
                    .onChange(of: characterName) {
                        triggerChangeChannel.toggle()
                    }
                    // Here, the image won't move if the text changes from two-lines to one-line or vice versa
                    .padding(.vertical, Constants.CharacterView.verticalPadding)
                    .padding(.horizontal)
                    .offset(y: -10)
                )
        }
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}

