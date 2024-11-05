//
//  GameOverView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI

struct GameOverView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var isPresented: Bool
    @State private var trigger = false
    @State private var opacity: Double = 0.0
    var text = ""
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                
                Spacer()
                
                GlitchTextEffect(text: "Game Over", intensity: Constants.GameOverView.glitchTextIntensity)
                    .padding(.vertical)
                HackerTextView(
                    text: gameplayVM.getGameOverReason() ?? "",
                    trigger: trigger,
                    transition: .identity,
                    speed: Constants.GameOverView.hackerTextSpeed
                )
                .fontDesign(.monospaced)
                .lineLimit(Constants.GameOverView.hackerTextLineLimit)
                .multilineTextAlignment(.center)
                .font(.bodyFont)
                .padding()
                
                Spacer()
                
            }
            
            Button("Restart") {
                gameplayVM.resetGame()
                isPresented = false
            }
            .padding()
            .opacity(opacity)
            .font(.title1Font)
            .buttonStyle(.bordered)
            .tint(.pink)
            
            Spacer()
            
        }
        .task {
            try? await Task.sleep(nanoseconds: Constants.GameOverView.buttonOpacityDelay)
            trigger.toggle()
            withAnimation(.easeInOut(duration: Constants.GameOverView.buttonAnimationDuration)) {
                opacity = 1
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

