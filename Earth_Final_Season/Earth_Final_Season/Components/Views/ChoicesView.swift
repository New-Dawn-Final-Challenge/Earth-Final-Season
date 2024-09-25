//
//  ChoicesView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI

struct ChoicesView: View {
    let choiceDescription: String
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 150, height: 70)
                .overlay(
                    Text("\(choiceDescription)")
                        .font(.title)
                        .foregroundColor(.white)
                )
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
    }
}

#Preview {
    ChoicesView(choiceDescription: "Option 1")
}
