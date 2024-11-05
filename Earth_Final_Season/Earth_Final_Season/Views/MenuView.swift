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
                
                VStack(spacing: Constants.MenuView.verticalSpacing) {
                    // Title of the game
                    Text("Earth: Final Season")
                        .frame(width: getWidth() * Constants.MenuView.titleWidthMultiplier,
                               height: getHeight() * Constants.MenuView.titleHeightMultiplier)
                        .background(Assets.Colors.textSecondary.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    
                    // Navigation buttons
                    NavigationLink(destination: GameplayView(settingsVM: $settingsVM,
                                                             leaderboardVM: $leaderboardVM)) {
                        Text("Play")
                            .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                                   height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    }
                    
                    Button(action: {
                        isGameCenterPresented.toggle()
                    }) {
                        Text("Leaderboard")
                            .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                                   height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    }
                    .sheet(isPresented: $isGameCenterPresented) {
                        LeaderboardView()
                    }
                    
                    NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                        Text("Settings")
                            .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                                   height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    }
                    
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                            .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                                   height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    }
                }
                .font(.bodyFont)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
