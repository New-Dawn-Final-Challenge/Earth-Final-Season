//
//  LeaderboardCardView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 09/10/24.
//

import SwiftUI

struct LeaderboardCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(Color(UIColor.systemGray4))
            .frame(width: getWidth() * 0.75,
                   height: getHeight() * 0.12)
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Text("Username")

                        HStack {
                            Image(systemName: "crown.fill")
                            Text("30 years")
                        }

                        HStack {
                            Image(systemName: "hands.clap.fill")
                            Text("10 thousand viewers")
                        }
                    }

                    Spacer()
                }
                .padding()
                .padding(.leading, 30)
            )
            .overlay(
                HStack {
                    VStack {
                        Circle()
                            .foregroundStyle(Color(UIColor.systemCyan))
                            .frame(width: getWidth() * 0.14)
                        
                        Spacer()
                    }
                    .padding(-16)
                    
                    Spacer()
                }
            )
    }
}

#Preview {
    LeaderboardCardView()
}
