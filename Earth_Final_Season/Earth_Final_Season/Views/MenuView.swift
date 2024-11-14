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
    @State var settingsVM = SettingsViewModel()
    @State var leaderboardVM = LeaderboardViewModel()
    @State var aboutUsVM = AboutUsViewModel()
    
    @State private var isGameCenterPresented = false
    
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
            }
        }
    }
    
    private var buttonsView: some View {
        VStack(spacing: Constants.MenuView.verticalSpacing) {
            MenuButtonView(destination: GameplayView(settingsVM: $settingsVM, leaderboardVM: $leaderboardVM),
                           label: "Play")
            
            menuButton("Leaderboard") {
                isGameCenterPresented.toggle()
            }
            .sheet(isPresented: $isGameCenterPresented) {
                LeaderboardView()
            }
            
            menuButton("Settings") {
                settingsVM.isPresentedinMenu.toggle()
            }
            .fullScreenCover(isPresented: $settingsVM.isPresentedinMenu) {
                ZStack {
                    Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                    SettingsModalView(vm: $settingsVM, text: "Settings", doStuff: {})
                }
                .presentationBackground(.clear)
            }
            
            menuButton("About Us") {
                aboutUsVM.isPresentedInMenu.toggle()
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
