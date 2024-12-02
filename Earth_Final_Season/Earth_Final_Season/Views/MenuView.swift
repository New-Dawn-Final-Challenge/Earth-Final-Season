//
//  MenuView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI
import Design_System
import GameKit

struct MenuView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State var menuVM = MenuViewModel()
    @State var settingsVM = SettingsViewModel()
    @State var leaderboardVM = LeaderboardViewModel()
    @State var aboutUsVM = AboutUsViewModel()
    @State var characterGalleryVM = CharacterGalleryViewModel()
    @State var endingsGalleryVM = EndingsGalleryViewModel()
    
    @State private var navigateToGameplay = false
    @State private var isGameCenterPresented = false
    @State private var isShowingVideo: Bool = false
    @State private var hideNonGalleryButtons = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    BackgroundView()
                }
                .overlay(Color.black.opacity(0.6)).blur(radius: 1.5)
                
                VStack {
                    Spacer()
                    
                    Assets.Images.titleView.swiftUIImage
                    Assets.Images.globeView.swiftUIImage
                    buttonsView
                    
                    Spacer()
                }
            }
            .font(.bodyFont)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !GKLocalPlayer.local.isAuthenticated {
                leaderboardVM.authenticateUser()
                SoundtrackAudioManager.shared.playSoundtrack(named: "menu")
            }
        }
    }
    
    private var buttonsView: some View {
        VStack(spacing: Constants.MenuView.verticalSpacing) {
            Group {
                if !hideNonGalleryButtons {
                    if menuVM.firstTimePlaying {
                        menuButton(gameplayVM.isPortuguese ? "Jogar" : "Play") {
                            isShowingVideo = true
                            SoundtrackAudioManager.shared.stopSoundtrack()
                        }
                        .padding(.bottom, -12)
                        .fullScreenCover(isPresented: $isShowingVideo) {
                            VideoView(menuVM: $menuVM,
                                      navigateToGameplay: $navigateToGameplay)
                        }
                    } else {
                        MenuButtonView(destination: GameplayView(settingsVM: $settingsVM, leaderboardVM: $leaderboardVM),
                                       label: gameplayVM.isPortuguese ? "Jogar" : "Play")
                        .padding(.bottom, -12)
                    }
                    
                    NavigationLink(destination: GameplayView(settingsVM: $settingsVM,
                                                             leaderboardVM: $leaderboardVM),
                                   isActive: $navigateToGameplay) {
                        EmptyView()
                    }
                    
                    menuButton(gameplayVM.isPortuguese ? "Ranking" : "Leaderboard") {
                        isGameCenterPresented.toggle()
                    }
                    .sheet(isPresented: $isGameCenterPresented) {
                        LeaderboardView()
                    }
                }
            }
            .transition(.opacity.combined(with: .move(edge: .leading)))
            
            Group {
                if hideNonGalleryButtons {
                    menuButton(gameplayVM.isPortuguese ? "Galeria de Personagens" : "Character Gallery") {
                        characterGalleryVM.isPresentedInMenu.toggle()
                    }
                    .fullScreenCover(isPresented: $characterGalleryVM.isPresentedInMenu) {
                        ZStack {
                            Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                            CharacterGalleryView(vm: $characterGalleryVM, text: gameplayVM.isPortuguese ? "Galeria de Personagens" : "Character Gallery", doStuff: {})
                        }
                        .presentationBackground(.clear)
                    }
                    
                    menuButton(gameplayVM.isPortuguese ? "Galeria de Finais" : "Ending Gallery") {
                        endingsGalleryVM.isPresentedInMenu.toggle()
                    }
                    .fullScreenCover(isPresented: $endingsGalleryVM.isPresentedInMenu) {
                        ZStack {
                            Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                            EndingsGalleryView(vm: $endingsGalleryVM, text: "Ending Gallery", doStuff: {})
                        }
                        .presentationBackground(.clear)
                    }
                    
                }
            }
            
            menuButton(gameplayVM.isPortuguese ? "Galerias" : "Galleries") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hideNonGalleryButtons.toggle()
                }
            }
            
            if hideNonGalleryButtons {
                // esses botoes escondidos aqui embaixo servem so para
                // deixar o espacamento igual
                menuButton("Galerias") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        hideNonGalleryButtons.toggle()
                    }
                }
                .hidden()
                .disabled(true)
                
                menuButton("Galerias") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        hideNonGalleryButtons.toggle()
                    }
                }
                .hidden()
                .disabled(true)
            }
            
            Group {
                if !hideNonGalleryButtons {
                    menuButton(gameplayVM.isPortuguese ? "Configurações" : "Settings") {
                        settingsVM.isPresentedinMenu.toggle()
                    }
                    .fullScreenCover(isPresented: $settingsVM.isPresentedinMenu) {
                        ZStack {
                            Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                            SettingsModalView(vm: $settingsVM, text: gameplayVM.isPortuguese ? "Configurações" : "Settings", doStuff: {})
                        }
                        .presentationBackground(.clear)
                    }
                    
                    menuButton(gameplayVM.isPortuguese ? "Sobre Nós" : "About Us") {
                        aboutUsVM.isPresentedInMenu.toggle()
                    }
                    .fullScreenCover(isPresented: $aboutUsVM.isPresentedInMenu) {
                        ZStack {
                            Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                            AboutUsView(vm: $aboutUsVM, text: gameplayVM.isPortuguese ? "Sobre Nós" : "About Us", doStuff: {})
                        }
                        .presentationBackground(.clear)
                    }
                }
            }
            .transition(.opacity.combined(with: .move(edge: .trailing)))
        }
        .padding(.top, -45)
        .animation(.easeInOut(duration: 0.3), value: hideNonGalleryButtons)
    }
    
    @ViewBuilder
    private func menuButton(_ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                       height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .foregroundColor(.white)
                .cornerRadius(Constants.MenuView.buttonCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                )
        }
    }
}

