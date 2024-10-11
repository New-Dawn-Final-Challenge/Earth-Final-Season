//
//  MenuView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI

struct MenuView: View {
    @State var gameplayViewModel = GameplayViewModel()
    @State var configViewModel = ConfigurationsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title of the game
                Text("Earth Final Season")
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                
                // Navigation buttons
                NavigationLink(destination: GameplayView(viewModel: $gameplayViewModel, configViewModel: $configViewModel)) {
                    Text("Jogar")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: RankingView()) {
                    Text("Ranking")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: ConfigurationsView(viewModel: $configViewModel)) {
                    Text("Configurações")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: AboutUsView()) {
                    Text("Sobre nós")
                        .frame(width: 200, height: 50)
                        .background(Color.pink.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
//            .navigationTitle("Menu")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
