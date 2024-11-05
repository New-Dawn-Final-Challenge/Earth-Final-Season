//
//  MenuView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI
import Design_System

struct MenuView: View {
    @State var settingsVM = SettingsViewModel()
    @State var leaderboardVM = LeaderboardViewModel()
    @State private var isGameCenterPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack(spacing: MenuViewConstants.verticalSpacing) {
                    // Title of the game
                    Text("Earth: Final Season")
                        .frame(width: getWidth() * MenuViewConstants.titleWidthMultiplier,
                               height: getHeight() * MenuViewConstants.titleHeightMultiplier)
                        .background(Assets.Colors.textSecondary.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(MenuViewConstants.buttonCornerRadius)
                    
                    // Navigation buttons
                    NavigationLink(destination: GameplayView(settingsVM: $settingsVM,
                                                             leaderboardVM: $leaderboardVM)) {
                        Text("Play")
                            .frame(width: getWidth() * MenuViewConstants.buttonWidthMultiplier,
                                   height: getHeight() * MenuViewConstants.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(MenuViewConstants.buttonCornerRadius)
                    }
                    
                    Button(action: {
                        isGameCenterPresented.toggle()
                    }) {
                        Text("Leaderboard")
                            .frame(width: getWidth() * MenuViewConstants.buttonWidthMultiplier,
                                   height: getHeight() * MenuViewConstants.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(MenuViewConstants.buttonCornerRadius)
                    }
                    .sheet(isPresented: $isGameCenterPresented) {
                        LeaderboardView()
                    }
                    
                    NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                        Text("Settings")
                            .frame(width: getWidth() * MenuViewConstants.buttonWidthMultiplier,
                                   height: getHeight() * MenuViewConstants.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(MenuViewConstants.buttonCornerRadius)
                    }
                    
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .frame(width: getWidth() * MenuViewConstants.buttonWidthMultiplier,
                                   height: getHeight() * MenuViewConstants.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(MenuViewConstants.buttonCornerRadius)
                    }
                }
                .font(.bodyFont)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
