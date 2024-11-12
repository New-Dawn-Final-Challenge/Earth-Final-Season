//
//  LeaderboardViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 10/10/24.
//

import SwiftUI
import GameKit

@Observable
class LeaderboardViewModel: ObservableObject {
    let leaderboardIdentifier = "com.EarthFinalSeason.Leaderboard"
    var isGameCenterPresented = false
    var playersList: [Player] = []
    var highestScore: Int = 0
    
    // Game Center Authentication
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Failed to authenticate")
                return
            }
        }
    }
    
    // Load Leaderboard Entries
    func loadLeaderboard() async {
        playersList.removeAll()
        do {
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
            if let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardIdentifier }) {
                let entries = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...5))
                if !entries.1.isEmpty {
                    for leaderboardEntry in entries.1 {
                        let image = try await leaderboardEntry.player.loadPhoto(for: .small)
                        let player = Player(name: leaderboardEntry.player.displayName, score: leaderboardEntry.formattedScore, image: image)
                        playersList.append(player)
                    }
                    playersList.sort { $0.score < $1.score }
                }
            }
        } catch {
            print("Error loading leaderboard: \(error.localizedDescription)")
        }
    }
    
    // Submit Score to Game Center
    func submitScore(scoreToSubmit: Int) async {
        do {
            try await GKLeaderboard.submitScore(scoreToSubmit, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [leaderboardIdentifier])
            print("Score of \(scoreToSubmit) years submitted successfully!")
        } catch {
            print("Error submitting score: \(error.localizedDescription)")
        }
    }
    
    func getLocalPlayerHighestScore() async {
        do {
            // Load the leaderboard entries
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
            
            // Find the leaderboard for the current game
            if let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardIdentifier }) {
                // Load the global leaderboard entries with a wide range
                let entries = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...100))
                
                // Find the entry for the local player
                if let localPlayerEntry = entries.1.first(where: { $0.player == GKLocalPlayer.local }) {
                    // Strip non-numeric characters and convert to an integer
                    if let numericScore = extractNumericScore(from: localPlayerEntry.formattedScore) {
                        highestScore = numericScore
                        print("Local player's highest score: \(highestScore)")
                    } else {
                        print("Failed to extract numeric score from formatted score.")
                    }
                } else {
                    print("No score available for the local player.")
                }
            } else {
                print("No leaderboard found with the given identifier.")
            }
        } catch {
            print("Error retrieving local player's highest score: \(error.localizedDescription)")
        }
    }

    // Function to extract the numeric part of the formatted score
    func extractNumericScore(from formattedScore: String) -> Int? {
        // Use a regular expression to match numeric characters
        let numericScore = formattedScore.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Return the numeric score as an integer
        return Int(numericScore)
    }

}
