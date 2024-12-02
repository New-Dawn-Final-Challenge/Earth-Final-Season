//
//  CharacterView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct CharacterView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State var characterImage: Image = Image("image1")
    @State private var triggerChangeChannel: Bool = false
    private var character: CharacterGallery
    private var rawCharacterName: String
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height

    private var characterName: String {
        let localized = character.name(isPortuguese: gameplayVM.isPortuguese)
        return localized.capitalized
    }

    init(character: String) {
        self.character = CharacterGallery.allCases.first { $0.name(isPortuguese: false).lowercased() == character.lowercased() } ?? .lockedCharacter
        self.rawCharacterName = self.character.name(isPortuguese: false)
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
                        characterImage = Utils.getImageByName(rawCharacterName)
                        SoundtrackAudioManager.shared.playSoundEffect(named: "changeCharacter", fileExtension: "wav", volume: 0.15)
                    }
                    .padding(.vertical, Constants.CharacterView.verticalPadding)
                    .padding(.horizontal, 2)
                    .offset(y: -10)
                )
        }
        .onAppear {
            triggerChangeChannel.toggle()
            characterImage = Utils.getImageByName(rawCharacterName)
        }
    }
}
