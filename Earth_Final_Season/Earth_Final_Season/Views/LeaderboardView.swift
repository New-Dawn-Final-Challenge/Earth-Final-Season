//
//  LeaderboardView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Record")
                .font(.title2.bold())

            LeaderboardCardView()
            
            Text("Leaderboard")
                .font(.title2.bold())
        }
        .padding()
        .navigationTitle("Leaderboard")
    }
}

#Preview {
    LeaderboardView()
}
