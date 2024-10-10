//
//  LeaderboardViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 10/10/24.
//

import SwiftUI
import GameKit

//class LeaderboardViewModel: NSObject, ObservableObject {
//    @Published var isAuthenticated = false
//    
//    override init() {
//        super.init()
//        authenticateUser()
//    }
//    
//    func authenticateUser() {
//        GKLocalPlayer.local.authenticateHandler = { vc, error in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//        }
//    }
//    
//    func loadLeaderboard() async {
//        playersList.removeAll()
//        Task{
//            var playersListTemp : [Player] = []
//            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
//            if let leaderboard = leaderboards.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
//                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...5))
//                if allPlayers.1.count > 0 {
//                    try await allPlayers.1.asyncForEach { leaderboardEntry in
//                        var image = try await leaderboardEntry.player.loadPhoto(for: .small)
//                        playersListTemp.append(Player(name: leaderboardEntry.player.displayName, score:leaderboardEntry.formattedScore, image: image))
//                                    print(playersListTemp)
//                        playersListTemp.sort{
//                            $0.score < $1.score
//                        }
//                    }
//                }
//            }
//            playersList = playersListTemp
//        }
//    }
//}
