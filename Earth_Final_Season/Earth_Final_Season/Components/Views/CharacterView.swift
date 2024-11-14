//
//  CharacterView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct CharacterView: View {
    @State var characterImage: Image = Image("image1")
    private var characterName: String
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var triggerChangeChannel: Bool = false
    
    
    init(character: String) {
        self.characterName = character
    }
    
    var body: some View {
        VStack {
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.CharacterView.imageFrameWidthMultiplier,
                       height: getHeight() * Constants.CharacterView.imageFrameHeightMultiplier)
            
                .overlay(
                    
                    VStack (spacing: 14) {
                        GlitchContentView(trigger: $triggerChangeChannel,
                                          uiImage: characterImage)
                        .frame(width: getWidth() * Constants.CharacterView.glitchViewWidthMultiplier,
                               height: getHeight() * Constants.CharacterView.glitchViewHeightMultiplier)
                        .mask(
                            RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                                .frame(width: getWidth() * Constants.CharacterView.glitchViewWidthMultiplier,
                                       height: getHeight() * Constants.CharacterView.glitchViewHeightMultiplier)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius:  getWidth() * Constants.CharacterView.characterViewCornerRadiusMultiplier,
                                        bottomLeadingRadius: getWidth() * Constants.CharacterView.characterViewCornerRadiusMultiplier / 2,
                                        bottomTrailingRadius: getWidth() * Constants.CharacterView.characterViewCornerRadiusMultiplier / 2 ,
                                        topTrailingRadius: getWidth() * Constants.CharacterView.characterViewCornerRadiusMultiplier
                                    )
                                )
                            
                        )
                        .padding(.top, 8)
                        
                        GlitchCharacterView(trigger: $triggerChangeChannel, characterName: characterName)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: 20)
                    }
                        .onChange(of: characterName) {
                            triggerChangeChannel.toggle()
                            characterImage = Utils.getImageByName(characterName)
                            SoundtrackAudioManager.shared.playSoundEffect(named: "changeCharacter", fileExtension: "wav", volume: 0.15)
                        }
                        .padding(.vertical, Constants.CharacterView.verticalPadding)
                        .padding(.horizontal)
                        .offset(y: -10)
                )
            
        }
        .onAppear {
            triggerChangeChannel.toggle()
            characterImage = Utils.getImageByName(characterName)
        }

    }
}

#Preview {
    CharacterView(character: "Slow Logistics Engineer")
}

