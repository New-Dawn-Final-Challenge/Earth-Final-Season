//
//  CharacterGalleryView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 26/11/24.
//

import SwiftUI
import Design_System

struct CharacterGalleryView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM

    @Binding var vm: CharacterGalleryViewModel
    var doStuff: () -> Void

    init(vm: Binding<CharacterGalleryViewModel>, text: String, doStuff: @escaping () -> Void) {
        self._vm = vm
        self.doStuff = doStuff
    }
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: Constants.CharacterGalleryView.gridSpacing),
                                            count: Constants.CharacterGalleryView.gridColumns)
    
    var body: some View {
        ZStack {
            popUpBackground
            
            ScrollView {
                VStack(spacing: Constants.CharacterGalleryView.vstackSpacing) {
                    closeButton
                    titleText
                    charactersUnlockedText(gameplayViewModel: gameplayVM)
                    
                    LazyVGrid(columns: columns, spacing: Constants.CharacterGalleryView.vstackSpacing) {
                        ForEach(CharacterGallery.allCases, id: \.self) { character in
                            characterComponent(character: character, gameplayViewModel: gameplayVM)
                        }
                    }
                    .padding(.top, Constants.CharacterGalleryView.vstackPadding)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .padding()
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
    
    private var closeButton: some View {
        HStack {
            Button(action: {
                vm.isPresentedInMenu.toggle()
                doStuff()
            }) {
                HelperButtonView(imageName: "xmark")
            }
            Spacer()
        }
        .padding(.bottom, Constants.CharacterGalleryView.closeButtonPadding)
    }

    private var titleText: some View {
        Text3dEffect(text: "Character\nGallery")
            .font(.largeTitleFont)
            .multilineTextAlignment(.center)
    }
    
    private func charactersUnlockedText(gameplayViewModel: GameplayViewModel) -> some View {
        Text("Characters unlocked: \(gameplayViewModel.unlockedCharacterCount)/\(gameplayViewModel.totalCharacterCount)")
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .font(.bodyFont)
    }
    
    private func characterComponent(character: CharacterGallery, gameplayViewModel: GameplayViewModel) -> some View {
        let unlockedCharacters = gameplayViewModel.getUnlockedCharacters()
        
        return RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
            .frame(width: getWidth() * Constants.CharacterGalleryView.characterComponentWidth,
                   height: getHeight() * Constants.CharacterGalleryView.characterComponentHeight)
            .overlay(
                VStack {
                    if unlockedCharacters.contains(character.name.lowercased()) {
                        characterInfoOverlay(character: character)
                    } else {
                        characterInfoOverlay(character: .lockedCharacter)
                    }
                    Spacer()
                }
            )
    }
    
    private func characterInfoOverlay(character: CharacterGallery) -> some View {
        VStack(spacing: Constants.CharacterGalleryView.characterInfoSpacing) {
            characterMonitor(character: character)
            characterName(character: character)
            characterDescription(character: character)
        }
        .font(.footnoteFont)
        .padding(Constants.CharacterGalleryView.characterInfoPadding)
    }
    
    private func characterMonitor(character: CharacterGallery) -> some View {
        Assets.Images.characterScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.CharacterGalleryView.characterMonitorWidth,
                   height: getHeight() * Constants.CharacterGalleryView.characterMonitorHeight)
            .overlay(character.image)
    }
    
    private func characterName(character: CharacterGallery) -> some View {
        Text(character.name)
            .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
            .shadow(color: .black,
                    radius: Constants.CharacterGalleryView.shadowRadius,
                    x: Constants.CharacterGalleryView.shadowX,
                    y: Constants.CharacterGalleryView.shadowY)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private func characterDescription(character: CharacterGallery) -> some View {
        Text(character.description)
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
}
