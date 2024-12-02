//
//  CharacterGalleryView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 26/11/24.
//

import SwiftUI
import Design_System

struct EndingsGalleryView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State private var triggerGlitch = false
    @Binding var vm: EndingsGalleryViewModel
    var doStuff: () -> Void

    init(vm: Binding<EndingsGalleryViewModel>, text: String, doStuff: @escaping () -> Void) {
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
                    endingsUnlockedText(gameplayViewModel: gameplayVM)
                    
                    LazyVGrid(columns: columns, spacing: Constants.CharacterGalleryView.vstackSpacing) {
                        ForEach(EndingsGallery.allCases.filter { $0 != .lockedEnding }, id: \.self) { ending in
                            endingComponent(ending: ending, gameplayViewModel: gameplayVM)
                        }
                    }
                    .padding(.top, Constants.CharacterGalleryView.vstackPadding)
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    triggerGlitch = true
                    SoundtrackAudioManager.shared.playSoundEffect(named: "changeCharacter", fileExtension: "wav", volume: 0.15)
                }
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
        Text3dEffect(text: gameplayVM.isPortuguese ?  "Galeria de\nFinais" : "Endings\nGallery")
            .font(.largeTitleFont)
            .multilineTextAlignment(.center)
    }
    
    private func endingsUnlockedText(gameplayViewModel: GameplayViewModel) -> some View {
        if gameplayVM.isPortuguese {
            Text("Finais desbloqueados: \(gameplayViewModel.getUnlockedEndings().count)/\(gameplayViewModel.totalEndingsCount)")
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                .font(.bodyFont)
        } else {
            Text("Endings unlocked: \(gameplayViewModel.getUnlockedEndings().count)/\(gameplayViewModel.totalEndingsCount)")
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                .font(.bodyFont)
        }
        
    }
    
    private func endingComponent(ending reason: EndingsGallery, gameplayViewModel: GameplayViewModel) -> some View {
        let unlockedEndings = gameplayViewModel.getUnlockedEndings()
        
        return RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
            .frame(width: getWidth() * Constants.CharacterGalleryView.characterComponentWidth,
                   height: getHeight() * Constants.CharacterGalleryView.characterComponentHeight)
            .overlay(
                VStack {
                    if unlockedEndings.contains(reason.ending.lowercased()) {
                        endingInfoOverlay(ending: reason)
                    } else {
                        endingInfoOverlay(ending: .lockedEnding)
                    }
                    Spacer()
                }
            )
    }
    
    private func endingInfoOverlay(ending: EndingsGallery) -> some View {
        VStack(spacing: Constants.CharacterGalleryView.characterInfoSpacing) {
            endingMonitor(ending: ending)
            endingName(ending: ending)
            endingDescription(ending: ending)
        }
        .font(.footnoteFont)
        .padding(Constants.CharacterGalleryView.characterInfoPadding)
    }
    
    private func endingMonitor(ending: EndingsGallery) -> some View {
        Assets.Images.characterScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.CharacterGalleryView.characterMonitorWidth,
                   height: getHeight() * Constants.CharacterGalleryView.characterMonitorHeight)
            .overlay(
                GlitchContentView(trigger: $triggerGlitch, uiImage: ending.image)
                    .frame(width: getWidth() * Constants.EndingsGalleryView.monitorDisplayWidth)
                    .mask(
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: getWidth() * Constants.CharacterGalleryView.characterMonitorWidth * 0.8,
                                   height: getHeight() * Constants.CharacterGalleryView.characterMonitorHeight  * 0.8)
                    )
            )
    }
    
    private func endingName(ending: EndingsGallery) -> some View {
        Group {
            if ending == EndingsGallery.lockedEnding {
                HackerTextView(text: ending.ending, duration: 99)
            } else {
                Text(ending.displayTranslated(isPortuguese: gameplayVM.isPortuguese))
            }
        }
            .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
            .shadow(color: .black,
                    radius: Constants.CharacterGalleryView.shadowRadius,
                    x: Constants.CharacterGalleryView.shadowX,
                    y: Constants.CharacterGalleryView.shadowY)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private func endingDescription(ending: EndingsGallery) -> some View {
        Group {
            if ending == EndingsGallery.lockedEnding {
                HackerTextView(text: ending.ending, duration: 99)
            } else {
                Text(ending.getDescritption(isPortuguese: gameplayVM.isPortuguese))
            }
        }
        .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
    }
}
