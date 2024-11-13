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
                    
                    VStack (spacing: 9) {
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
                            getImageByName()
                            SoundtrackAudioManager.shared.playSoundEffect(named: "changeCharacter", fileExtension: "wav", volume: 0.15)
                        }
                        .padding(.vertical, Constants.CharacterView.verticalPadding)
                        .padding(.horizontal)
                        .offset(y: -10)
                )
                
        }
        .onAppear {
            triggerChangeChannel.toggle()
            getImageByName()
        }
        
    }
    
    func getImageByName() {
        switch characterName.lowercased() {
        case "ultra new age environmentalist":
            characterImage =  Assets.Images.ultraNewAgeEnvironmentalist.swiftUIImage
        case "fearless economist":
            characterImage =  Assets.Images.fearlessEconomist.swiftUIImage
            
        case "apocalyptical cat":
            characterImage =  Assets.Images.apocalypticalCat.swiftUIImage
            
        case "chronically online teenager":
            characterImage =  Assets.Images.chronicallyOnlineTeenager.swiftUIImage
            
        case "conspiracy theorist":
            characterImage =  Assets.Images.conspiracyTheoristPodcaster.swiftUIImage
            
        case "chaotic billionaire":
            characterImage =  Assets.Images.chaocticBillionaire.swiftUIImage
            
        case "evil researcher":
            characterImage =  Assets.Images.evilResearcher.swiftUIImage
            
        case "experimentalist geneticist":
            characterImage =  Assets.Images.experimentalistGeneticist.swiftUIImage
            
        case "indie physician":
            characterImage =  Assets.Images.indiePhysician.swiftUIImage
            
        case "president in denial":
            characterImage =  Assets.Images.presidentInDenial.swiftUIImage
            
        case "questionable religious leader":
            characterImage =  Assets.Images.questionableReligiousLeader.swiftUIImage
            
        case "robot vacuum cleaner":
            characterImage =  Assets.Images.robotVacumCleaner.swiftUIImage
            
        case "sensationalist tv host":
            characterImage =  Assets.Images.sensionalistTVHost.swiftUIImage
            
        case "slow logistics engineer":
            characterImage =  Assets.Images.slowLogisticEngineer.swiftUIImage
            
        default:
            characterImage =  Image("image1")
        }
    }
}

#Preview {
    CharacterView(character: "Slow Logistics Engineer")
}

