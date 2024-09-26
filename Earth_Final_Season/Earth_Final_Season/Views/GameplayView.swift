import SwiftUI

struct GameplayView: View {
    @State var viewModel = GameplayViewModel()
    
    var body: some View {
        VStack {
            HStack {
                AudienceIndicatorView(percentage: viewModel.indicators.audience)
                    .padding()
                ChaosIndicatorsView(
                    socialInstability: viewModel.indicators.socialInstability,
                    politicalInstability: viewModel.indicators.politicalInstability,
                    environmentalDegradation: viewModel.indicators.environmentalDegradation,
                    Year: String(viewModel.indicators.currentYear)
                )
                .padding()
            }
            
            if let event = viewModel.currentEvent {
                CharacterView(characterImage: "Placeholder", characterName: event.character)
                    .padding()
                
                EventView(eventDescription: event.description)
                    .padding()
                
                HStack {
                    Button(action: {
                        viewModel.chooseOption1()
                    }) {
                        ChoicesView(choiceDescription: event.choice1)
                    }
                    Button(action: {
                        viewModel.chooseOption2()
                    }) {
                        ChoicesView(choiceDescription: event.choice2)
                    }
                }
                .padding()
            } else {
                Text("No more events")
                    .font(.title)
                    .padding()
            }
            
            SliderView()
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    GameplayView()
}
