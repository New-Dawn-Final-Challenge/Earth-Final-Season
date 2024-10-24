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
                GlitchTextEffect(text: "Game Over", intensity: 2)
                    .font(.largeTitle)
                    .padding()
                HackerTextView(text: gameplayVM.getGameOverReason() ?? "Crossed the road without looking at both sides",
                               trigger: trigger,
                               transition: .identity,
                               speed: 0.001
                )
                .lineLimit(4)
                .font(.title3)
                .padding()
                Spacer()
            }
            Button("Restart") {
                gameplayVM.resetGame()
                isPresented = false
            }
            .padding()
            .opacity(opacity)
            .font(.title)
            .buttonStyle(.bordered)
            .tint(.pink)
            Spacer()
        }
        .task {
            try? await Task.sleep(nanoseconds: 4500000000)
            trigger.toggle()
            withAnimation(.easeInOut(duration: 4.5)) {
                opacity = 1
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
                
    }
}
