//
//  GameOverView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI

struct GameOverView: View {
    @Binding var gameplayViewModel: GameplayViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            
            Text("Game over reason was '\(gameplayViewModel.gameOverReason)'.")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)

            Button("Restart") {
                gameplayViewModel.resetGame()
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}
