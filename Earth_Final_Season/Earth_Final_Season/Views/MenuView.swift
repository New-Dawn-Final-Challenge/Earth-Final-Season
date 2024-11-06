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
                    gameTitleView
                    
                    MenuButtonView(destination: GameplayView(settingsVM: $settingsVM, leaderboardVM: $leaderboardVM),
                                   label: "Play")
                    
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
                    
                    MenuButtonView(destination: SettingsView(settingsVM: $settingsVM),
                                   label: "Settings")
                    
                    MenuButtonView(destination: AboutUsView(), label: "About Us")
                }
                .font(.bodyFont)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var gameTitleView: some View {
        Text("Earth: Final Season")
            .frame(width: getWidth() * Constants.MenuView.titleWidthMultiplier,
                   height: getHeight() * Constants.MenuView.titleHeightMultiplier)
            .background(Assets.Colors.textSecondary.swiftUIColor)
            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
            .cornerRadius(Constants.MenuView.buttonCornerRadius)
    }
}

struct MenuButtonView<Destination: View>: View {
    var destination: Destination
    var label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                       height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                .cornerRadius(Constants.MenuView.buttonCornerRadius)
        }
    }
}
