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
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            
            Text("Game over reason was '\(gameplayVM.gameOverReason)'.")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)

            Button("Restart") {
                gameplayVM.resetGame()
                isPresented = false
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}
