//
//  LeaderboardView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Your Record")
                    .font(.title2.bold())
                
                LeaderboardCardView()
                
                Text("Global Records")
                    .font(.title2.bold())
                
                ForEach(0..<6, id: \.self) { _ in
                    LeaderboardCardView()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Leaderboard")
        }
    }
}

#Preview {
    LeaderboardView()
}
