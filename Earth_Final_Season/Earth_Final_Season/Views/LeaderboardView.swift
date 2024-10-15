//
//  LeaderboardView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI
import GameKit

struct LeaderboardView: View {
    @State private var leaderboardVM = LeaderboardViewModel()

    var body: some View {
        GameCenterView(viewController: GKGameCenterViewController(state: .leaderboards))
            .onAppear {
                if !GKLocalPlayer.local.isAuthenticated {
                    leaderboardVM.authenticateUser()
                } else if leaderboardVM.playersList.isEmpty {
                    Task {
                        await leaderboardVM.loadLeaderboard()
                    }
                }
            }
    }
}

#Preview {
    LeaderboardView()
}
