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
            VStack(spacing: 20) {
                // Title of the game
                Text("Earth: Final Season")
                    .frame(width: getWidth() * 0.5,
                           height: getHeight() * 0.06)
                    .background(Assets.Colors.textSecondary.swiftUIColor)
                    .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                    .cornerRadius(10)
                
                // Navigation buttons
                NavigationLink(destination: GameplayView(settingsVM: $settingsVM,
                                                         leaderboardVM: $leaderboardVM)) {
                    Text("Play")
                        .frame(width: getWidth() * 0.5,
                               height: getHeight() * 0.06)
                        .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isGameCenterPresented.toggle()
                }) {
                    Text("Leaderboard")
                        .frame(width: getWidth() * 0.5,
                               height: getHeight() * 0.06)
                        .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isGameCenterPresented) {
                    LeaderboardView()
                }
                
                NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                    Text("Settings")
                        .frame(width: getWidth() * 0.5,
                               height: getHeight() * 0.06)
                        .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: AboutUsView()) {
                    Text("About Us")
                        .frame(width: getWidth() * 0.5,
                               height: getHeight() * 0.06)
                        .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                        .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                        .cornerRadius(10)
                }
            }
            .font(.bodyFont)
        }
        .navigationBarBackButtonHidden(true)
    }
}
