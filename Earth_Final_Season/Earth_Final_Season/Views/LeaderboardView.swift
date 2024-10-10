//
//  LeaderboardView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI
import GameKit

struct LeaderboardView: View {
    @StateObject private var viewModel = LeaderboardViewModel()
    @State private var isGameCenterPresented = false
    @State private var scoreToSubmit: Int = 2 // Example score to submit
    let leaderboardIdentifier = "maximumYears" // Replace with your leaderboard ID

    var body: some View {
        VStack {
            // Submit Score Button
            Button("Submit Score") {
                Task {
                    await submitScore()
                }
            }
            .padding()
            
            // Show Leaderboard Button
            Button("Show Leaderboard") {
                isGameCenterPresented = true
            }
            .padding()
            .sheet(isPresented: $isGameCenterPresented) {
                GameCenterView(viewController: GKGameCenterViewController(state: .leaderboards))
            }
        }
        .onAppear {
            if !GKLocalPlayer.local.isAuthenticated {
                authenticateUser()
            } else if viewModel.playersList.isEmpty {
                Task {
                    await loadLeaderboard()
                }
            }
        }
    }
    
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
        viewModel.playersList.removeAll()
        do {
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
            if let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardIdentifier }) {
                let entries = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...5))
                if !entries.1.isEmpty {
                    for leaderboardEntry in entries.1 {
                        let image = try await leaderboardEntry.player.loadPhoto(for: .small)
                        let player = Player(name: leaderboardEntry.player.displayName, score: leaderboardEntry.formattedScore, image: image)
                        viewModel.playersList.append(player)
                    }
                    viewModel.playersList.sort { $0.score < $1.score }
                }
            }
        } catch {
            print("Error loading leaderboard: \(error.localizedDescription)")
        }
    }
    
    // Submit Score to Game Center
    func submitScore() async {
        do {
            try await GKLeaderboard.submitScore(scoreToSubmit, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [leaderboardIdentifier])
            print("Score submitted successfully!")
        } catch {
            print("Error submitting score: \(error.localizedDescription)")
        }
    }
}

struct Player {
    let name: String
    let score: String
    let image: UIImage?
}

class LeaderboardViewModel: ObservableObject {
    @Published var playersList: [Player] = []
}

public struct GameCenterView: UIViewControllerRepresentable {
    let viewController: GKGameCenterViewController
    @AppStorage("IsGameCenterActive") var isGKActive:Bool = false

    public init(viewController: GKGameCenterViewController = GKGameCenterViewController(), format:GKGameCenterViewControllerState = .default ) {
        self.viewController = GKGameCenterViewController(state: format)
    }

    public func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gkVC = viewController
        gkVC.gameCenterDelegate = context.coordinator
        return gkVC
    }

    public func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
        return
    }

    public func makeCoordinator() -> GKCoordinator {
        return GKCoordinator(self)
    }
}

public class GKCoordinator: NSObject, GKGameCenterControllerDelegate {
    var view: GameCenterView

    init(_ gkView: GameCenterView) {
        self.view = gkView
    }

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        view.isGKActive = false
    }
}

#Preview {
    LeaderboardView()
}
