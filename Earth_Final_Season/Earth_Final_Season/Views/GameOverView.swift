//
//  GameOverView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI
import Design_System

struct GameOverView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var isPresented: Bool
    @Binding var leaderboardVM: LeaderboardViewModel
    var doStuff: ()-> Void
    
    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: Constants.GameOverView.vstackSpacing) {
                Spacer()
                
                gameOverTitle
                yearReachedText
                gameOverImage(image: gameplayVM.getGameOverImage() ?? Assets.Images.placeholderCharacter.swiftUIImage)
                gameOverDescription(title: gameplayVM.getGameOverTitle() ?? "",
                                    description: gameplayVM.getGameOverReason() ?? "")
                gameOverButtons
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
    
    private var popUpBackground: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: Constants.Global.lineWidth)
            .background(
                RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                    .foregroundStyle(Color.black)
            )
    }
    
    private var gameOverTitle: some View {
        GlitchTextEffect(text: "Game Over", intensity: Constants.GameOverView.glitchTextIntensity)
    }
    
    private var yearReachedText: some View {
        VStack {
            if (gameplayVM.getIndicators()?.currentYear ?? 0) <= leaderboardVM.highestScore {
                // Player did not beat the previous highest score
                Text("You ran the show for \(gameplayVM.getIndicators()?.currentYear ?? 0) years")
            } else {
                // Player reached a new record
                HStack(alignment: .bottom) {
                    starView
                    Text("New Record!")
                    starView
                }
                Text("\(gameplayVM.getIndicators()?.currentYear ?? 0) years")
            }
        }
        .font(.title3Font)
        .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
    }
    
    private var starView: some View {
        Image(systemName: "star.fill")
            .shadow(color: Assets.Colors.accentPrimary.swiftUIColor.opacity(Constants.GameOverView.starViewOpacity),
                    radius: Constants.GameOverView.starViewRadius,
                    x: Constants.GameOverView.starViewX,
                    y: Constants.GameOverView.starViewY)
    }
    
    private func gameOverImage(image: Image) -> some View {
        ZStack {
            Assets.Images.eventsScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.GameOverView.gameOverMonitorImageWidth,
                       height: getHeight() * Constants.GameOverView.gameOverMonitorImageHeight)
            
            image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: Constants.GameOverView.gameOverImageRadius))
                .padding(.horizontal, Constants.GameOverView.gameOverImagePaddingHorizontal)
                .padding(.vertical, Constants.GameOverView.gameOverImagePaddingVertical)
        }
    }
    
    private func gameOverDescription(title: String, description: String) -> some View {
        VStack(spacing: Constants.GameOverView.vstackComponentsSpacing) {
            Text(title)
                .shadow(color: .black, radius: Constants.GameOverView.titleShadowRadius)
            Text(description)
        }
        .fixedSize(horizontal: false, vertical: true)
        .font(.bodyFont)
        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
        .padding(Constants.GameOverView.descriptionPadding)
        .frame(width: getWidth() * Constants.GameOverView.descriptionWidth,
               height: getHeight() * Constants.GameOverView.descriptionHeight)
        .background(
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
        )
    }
    
    private func buttonView(label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .padding()
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.Global.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                }
        }
        .padding(.horizontal)
        .font(.bodyFont)
    }
    
    private var gameOverButtons: some View {
        VStack(spacing: Constants.GameOverView.vstackComponentsSpacing) {
            buttonView(label: "Play again") {
                gameplayVM.resetGame()
                isPresented.toggle()
            }
            
            buttonView(label: "Menu") {
                gameplayVM.resetGame()
                isPresented.toggle()
                doStuff()
            }
        }
    }
}
