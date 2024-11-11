//
//  GameOverTestView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 11/11/24.
//

import SwiftUI
import Design_System

struct GameOverTestView: View {
    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: 16) {
                Spacer()
                
                gameOverTitle
                yearReachedText
                gameOverImage
                gameOverDescription
                gameOverButtons
                
                Spacer()
            }
            .padding()
        }
        .padding()
        .background(
            Color.black
        )
    }
    
    private var popUpBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: 1)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.black.opacity(0.5))
            )
    }
    
    private var gameOverTitle: some View {
        Text("Game Over")
            .font(.largeTitleFont)
            .foregroundStyle(Assets.Colors.alert.swiftUIColor)
            .shadow(color: Assets.Colors.alert.swiftUIColor,
                    radius: 3, x: -3, y: 3)
    }
    
    private var yearReachedText: some View {
        VStack {
            HStack(alignment: .bottom) {
                starView
                Text("New Record!")
                starView
            }
            
            Text("12 years")
        }
        .font(.title3Font)
        .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
        
//        Text("You ran the show for 12 years")
//            .font(.title3Font)
//            .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
//            .multilineTextAlignment(.center)
    }
    
    private var starView: some View {
        Image(systemName: "star.fill")
            .shadow(color: Assets.Colors.accentPrimary.swiftUIColor.opacity(0.6),
                    radius: 2, x: -2, y: 2)
    }
    
    private var gameOverImage: some View {
        ZStack {
            // Background image
            Assets.Images.eventsScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.8,
                       height: getHeight() * 0.16)
            
            // Foreground image with padding
            Assets.Images.audienceEnd.swiftUIImage
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
        }
    }

    private var gameOverDescription: some View {
        VStack(spacing: 12) {
            Text("Environmental Degradation reached its peak!")
                .shadow(color: .black, radius: 0.3, x: 0, y: 0)

            Text("Chemtrails in the sky give sunrays a strange purple glow. The waters stink of green, the weather is either burning hot, or deadly cold, and fruits and crops never grow. Toc toc: any human alive? The answer is no.")
        }
        .fixedSize(horizontal: false, vertical: true)
        .font(.bodyFont)
        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
        .padding(40)
        .frame(width: getWidth() * 0.8,
               height: getHeight() * 0.35)
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
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 1)
                }
        }
        .padding(.horizontal)
        .font(.bodyFont)
    }
    
    private var gameOverButtons: some View {
        VStack(spacing: 12) {
            buttonView(label: "Play again") {
                // action
            }
            buttonView(label: "Menu") {
                // action
            }
        }
    }
}

#Preview {
    GameOverTestView()
}
