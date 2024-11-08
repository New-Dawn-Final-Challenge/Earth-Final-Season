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
    
    
    @State private var dragOffset = CGSize.zero
    @State private var finalOffsetX: CGFloat = 0
    @State private var feedbackTrigger: CGPoint = .zero
    
    private var sliderWidth: CGFloat { getWidth() * Constants.SliderView.widthMultiplier }
    private var sliderHeight: CGFloat { getHeight() * Constants.SliderView.heightMultiplier }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .position(x: getWidth()/2, y: getHeight()/Constants.MenuView.backgroundHeightDivider)
                    .overlay(
                        Color.black.opacity(0.5) // Adjust opacity for desired darkness
                    )
                
                Assets.Images.globeView.swiftUIImage
                    .position(x: getWidth()/2, y: getHeight()/Constants.MenuView.globeHeightDivider)
                
                VStack() {
                    
                    Spacer()
                    
                    gameTitleView
                        .padding(.top, getHeight()/Constants.MenuView.gamePaddingTop)
                        .padding(.bottom, getHeight()/Constants.MenuView.gamePaddingBottom)
                  
                    buttonView
                    
                    Spacer()
                    
                    sliderControlView
                        .position(x: getWidth()/2, y: getHeight()/6)
                }
                .font(.bodyFont)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var gameTitleView: some View {
        Assets.Images.titleView.swiftUIImage
    }
    
    private var buttonView: some View {
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
                    .overlay( // Contorno colorido ao redor do botão
                        RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                            .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 2) // Ajuste a cor e a espessura do contorno
                    )
            }
            .sheet(isPresented: $isGameCenterPresented) {
                LeaderboardView()
            }
            
            MenuButtonView(destination: SettingsView(settingsVM: $settingsVM),
                           label: "Settings")
            
            MenuButtonView(destination: AboutUsView(), label: "About Us")
        }
    }
    
    private var sliderControlView: some View {
        VStack{
            Assets.Images.monitorsAll.swiftUIImage
                .resizable()
                .scaledToFit()
                .blur(radius: 1, opaque: true)
                .overlay(
                    Color.black.opacity(0.5) // Adjust opacity for desired darkness
                )
        }
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
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .foregroundColor(Color.white)
                .cornerRadius(Constants.MenuView.buttonCornerRadius)
                .overlay( // Contorno colorido ao redor do botão
                   RoundedRectangle(cornerRadius: Constants.MenuView.buttonCornerRadius)
                    .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 2) // Ajuste a cor e a espessura do contorno
               )
        }
    }
}


