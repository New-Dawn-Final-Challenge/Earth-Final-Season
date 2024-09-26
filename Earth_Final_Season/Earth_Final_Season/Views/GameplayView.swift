//
//  ContentView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 19/09/24.
//

import SwiftUI

struct GameplayView: View {
    // @State var viewModel = GameplayViewModel(events: mockEvents)
    
    var body: some View {
        VStack{
            
            HStack {
                AudienceIndicatorView(percentage: 55)
                    .padding()
                ChaosIndicatorsView(socialInstability: 0, politicalInstability: 0, environmentalDegradation: 0, Year: "2070")
                    .padding()
            }
            
            CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
                .padding()
            
            EventView(eventDescription: "Event")
                .padding()
            HStack{
                ChoicesView(choiceDescription: "Option 1")
                ChoicesView(choiceDescription: "Option 2")
            }
            .padding()
            
            SliderView()
                .padding()
            Spacer()
        }
    }
}

#Preview {
    GameplayView()
}
