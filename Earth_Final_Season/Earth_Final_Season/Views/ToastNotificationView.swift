//
//  ToastNotificationView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 28/11/24.
//

import SwiftUI
import Toast

struct ToastView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    let characterImage: Image
    let characterName: String

    var body: some View {
        HStack(spacing: 16) {
            characterImage
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))

            VStack(alignment: .leading) {
                Text(gameplayVM.isPortuguese ? "Novo Personagem Desbloqueado!" : "New Character Unlocked!")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(characterName)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
