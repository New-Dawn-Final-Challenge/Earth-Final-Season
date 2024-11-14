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
    @State var menuVM = MenuViewModel()
    @State var settingsVM = SettingsViewModel()
    @State var leaderboardVM = LeaderboardViewModel()
    @State var aboutUsVM = AboutUsViewModel()

    @State private var navigateToGameplay = false
    @State private var isGameCenterPresented = false
    @State private var isShowingVideo: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    BackgroundView()
                    // ControlPanelView(settingsVM: $settingsVM)
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
            }
        }
    }

    private var buttonsView: some View {
        VStack(spacing: Constants.MenuView.verticalSpacing){
            if menuVM.firstTimePlaying {
                Button (action: {
                    isShowingVideo = true
                    SoundtrackAudioManager.shared.stopSoundtrack()
                },
                        label: {
                    Text("Play")
                        .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                               height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                        .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(Constants.MenuView.buttonCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                                .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 2)
                        )
                })
                .fullScreenCover(isPresented: $isShowingVideo) {
                    VideoView(menuVM: $menuVM,
                              navigateToGameplay: $navigateToGameplay)
                }
            }

            else {
                MenuButtonView(destination: GameplayView(settingsVM: $settingsVM, leaderboardVM: $leaderboardVM),
                               label: "Play")
            }

            NavigationLink(destination: GameplayView(settingsVM: $settingsVM,
                                                     leaderboardVM: $leaderboardVM),
                           isActive: $navigateToGameplay) {
                EmptyView()
            }

            Button(action: {
                isGameCenterPresented.toggle()
            }) {
                Text("Leaderboard")
                    .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                           height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                    .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                            .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                    )
            }
            .sheet(isPresented: $isGameCenterPresented) {
                LeaderboardView()
            }
            .fullScreenCover(isPresented: $settingsVM.isPresentedinMenu) {
                ZStack {
                    Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                    SettingsModalView(vm: $settingsVM, text: "Menu Settings", doStuff: {
                        // do nothing
                        print("Do menu")
                    })
                    .frame(width: 400, height: 800)
                }
                .presentationBackground(.clear)
            }
            
            Button {
                settingsVM.isPresentedinMenu.toggle()
            } label: {
                Text("Settings")
                    .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                           height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                    .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    .overlay(
                       RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                   )
            }
            
            Button {
                aboutUsVM.isPresentedInMenu.toggle()
            } label: {
                Text("About Us")
                    .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                           height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                    .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    .overlay(
                       RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                   )
            }
            .fullScreenCover(isPresented: $aboutUsVM.isPresentedInMenu) {
                ZStack {
                    Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                    AboutUsView(vm: $aboutUsVM, text: "About Us", doStuff: {})
                }
                .presentationBackground(.clear)
            }
        }
        .padding(.top, -45)
    }
}
