//
//  MenuView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI

struct MenuView: View {
    @Environment(ChaosIndicatorsViewModel.self) private var chaosIndicatorsVM
    
    @State var settingsVM = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title of the game
                Text("Earth Final Season")
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                
                // Navigation buttons
                NavigationLink(destination: GameplayView(settingsVM: $settingsVM)) {
                    Text("Play")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: LeaderboardView()) {
                    Text("Leaderboard")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                    Text("Settings")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: AboutUsView()) {
                    Text("About Us")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
        }
    }
}
