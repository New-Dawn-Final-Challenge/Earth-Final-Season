import SwiftUI

struct GameplayView: View {
    @StateObject var viewModel = GameplayViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
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
                
                VStack(spacing: -15) {
                    CharacterView(characterImage: event.image, characterName: event.character)
                    
                    EventView(mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                              eventDescription: event.description)
                    
                }
                .padding(.bottom, -15)
                
                VStack(spacing: -20) {
                    OptionButton(shadowRadius: $viewModel.optionAShadowRadius,
                                 text: event.choice1)
                    .padding(.trailing, 100)
                    
                    OptionButton(shadowRadius: $viewModel.optionBShadowRadius,
                                 text: event.choice2)
                    .padding(.leading, 100)
                }
                
            } else {
                Text("No more events")
                    .font(.title)
                    .padding()
            }
            
            SliderView(
                optionToChoose: $viewModel.optionToChoose,
                mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                optionAShadowRadius: $viewModel.optionAShadowRadius,
                optionBShadowRadius: $viewModel.optionBShadowRadius,
                onChooseOptionA: {
                    viewModel.chooseOption1()
                },
                onChooseOptionB: {
                    viewModel.chooseOption2()
                }
            )
            
            Spacer()
        }
    }
}

#Preview {
    GameplayView()
}
