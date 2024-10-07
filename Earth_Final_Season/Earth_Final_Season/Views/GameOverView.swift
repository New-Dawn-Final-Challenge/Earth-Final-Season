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
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .padding()

            Button("Restart") {
                gameplayViewModel.resetGame()
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}
