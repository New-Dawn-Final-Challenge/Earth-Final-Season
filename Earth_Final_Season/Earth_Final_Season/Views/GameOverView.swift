//
//  GameOverView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI

struct GameOverView: View {
    @Binding var engine: GameEngine
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            
            Text("Game over reason was '\(engine.gameOverReason)'.")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)

            Button("Restart") {
                engine.resetGame()
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}
