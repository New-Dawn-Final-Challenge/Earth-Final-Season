import SwiftUI

struct GameplayView: View {
    @StateObject var viewModel = GameplayViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                AudienceIndicatorView(percentage: viewModel.indicators.audience)
                    .padding(.bottom)

                ChaosIndicatorsView(
                    socialInstability: viewModel.indicators.socialInstability,
                    politicalInstability: viewModel.indicators.politicalInstability,
                    environmentalDegradation: viewModel.indicators.environmentalDegradation,
                    year: String(viewModel.indicators.currentYear)
                )
            }
            
            if let event = viewModel.currentEvent {
                CharacterView(characterImage: event.image, characterName: event.character)
                    .padding()
                
                EventView(mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                          eventDescription: event.description)
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
            
//            SliderView()
//                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    GameplayView()
}
