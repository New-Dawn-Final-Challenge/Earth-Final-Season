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
    @State private var sobeSettings = false
    
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
                    
                    Button {
                        settingsVM.isPresented.toggle()
                    } label: {
                        Text("Settings")
                            .frame(width: getWidth() * Constants.MenuView.buttonWidthMultiplier,
                                   height: getHeight() * Constants.MenuView.buttonHeightMultiplier)
                            .background(Assets.Colors.secondaryGreenVariation.swiftUIColor)
                            .foregroundColor(Assets.Colors.fillPrimary.swiftUIColor)
                            .cornerRadius(Constants.MenuView.buttonCornerRadius)
                    }
                    
                    
                    MenuButtonView(destination: AboutUsView(), label: "About Us")
                }
                .font(.bodyFont)
            }
        }
        .fullScreenCover(isPresented: $settingsVM.isPresented) {
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea(edges: .all)
                        SettingsModalView(vm: $settingsVM, doStuff: {
                            // voltar pra tela anterior
                            print("Dismissei no menu")
                            
                        })
                            .frame(width: 400, height: 800)
                    }
                        .presentationBackground(.clear)
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
