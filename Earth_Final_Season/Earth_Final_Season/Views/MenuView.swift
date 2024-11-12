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
    
    @State private var isGameCenterPresented = false
    @State private var dragOffset = CGSize.zero
    @State private var finalOffsetX: CGFloat = 0
    @State private var feedbackTrigger: CGPoint = .zero
    
    private var sliderWidth: CGFloat { getWidth() * Constants.SliderView.widthMultiplier }
    private var sliderHeight: CGFloat { getHeight() * Constants.SliderView.heightMultiplier }
    
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
            MenuButtonView(destination: GameplayView(settingsVM: $settingsVM, leaderboardVM: $leaderboardVM),
                           label: "Play")
            
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
                            .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 2)
                    )
            }
            .sheet(isPresented: $isGameCenterPresented) {
                LeaderboardView()
            }
            
            MenuButtonView(destination: SettingsView(settingsVM: $settingsVM),
                           label: "Settings")
            
            MenuButtonView(destination: AboutUsView(), label: "About Us")
        }
        .padding(.top, -45)
    }
}
