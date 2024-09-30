import SwiftUI

struct GameplayView: View {
    @StateObject var viewModel = GameplayViewModel()
    
    var body: some View {
        VStack(spacing: 6) {
            helperButtonsView
            
            indicatorsView
            
            if let event = viewModel.currentEvent {

                CharacterView(characterImage: event.image, characterName: event.character)
                
                EventView(mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                          eventDescription: event.description)

                VStack(spacing: -20) {
                    ChoicesView(shadowRadius: $viewModel.option1ShadowRadius,
                                 text: event.choice1)
                    .padding(.trailing, 100)

                    ChoicesView(shadowRadius: $viewModel.option2ShadowRadius,
                                 text: event.choice2)
                    .padding(.leading, 100)
                }
                .padding(.top, -15)
            } else {
                Text("No more events")
                    .font(.title)
                    .padding()
            }
            
            SliderView(
                mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                option1ShadowRadius: $viewModel.option1ShadowRadius,
                option2ShadowRadius: $viewModel.option2ShadowRadius,
                onChooseOption1: {
                    viewModel.chooseOption1()
                },
                onChooseOption2: {
                    viewModel.chooseOption2()
                }
            )
            
            Spacer()
        }
        .onAppear(perform: prepareHaptics)
    }
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: ConfigurationsView(viewModel: ConfigurationsViewModel())) {
                HelpButtonView()
            }
            
            NavigationLink(destination: ConfigurationsView(viewModel: ConfigurationsViewModel())) {
                ConfigurationButtonView()
            }
        }
        .padding(.trailing)
    }
    
    private var indicatorsView: some View {
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
    }
}

#Preview {
    GameplayView()
}
