import SwiftUI

struct GameplayView: View {
    @Binding var viewModel: GameplayViewModel
    @Binding var configViewModel: ConfigurationsViewModel
    @State private var gameOver = false
    
    var body: some View {
        VStack(spacing: 6) {
            helperButtonsView
            
            indicatorsView
            
            if let event = viewModel.currentEvent {

                // Change image to current image
                CharacterView(characterImage: "image1", characterName: event.character)
                
                EventView(mainScreenShadowRadius: $viewModel.mainScreenShadowRadius, viewModel: $viewModel,
                          eventDescription: event.description,
                          consequence1: event.consequenceDescription1,
                          consequence2: event.consequenceDescription2
                )

                VStack(spacing: -20) {
                    ChoicesView(shadowRadius: $viewModel.option1ShadowRadius,
                                 text: event.choice1)
                    .padding(.trailing, 100)

                    ChoicesView(shadowRadius: $viewModel.option2ShadowRadius,
                                 text: event.choice2)
                    .padding(.leading, 100)
                }
                .padding(.top, -15)
                // Hide the choices to focus on the consequence
                .opacity(viewModel.isShowingConsequence ? 0 : 1)
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
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .navigationDestination(isPresented: $viewModel.isGameOver) {
            GameOverView(gameplayViewModel: $viewModel)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: ConfigurationsView(viewModel: $configViewModel)) {
                HelpButtonView()
            }
            
            NavigationLink(destination: ConfigurationsView(viewModel: $configViewModel)) {
                ConfigurationButtonView()
            }
        }
        .padding(.trailing)
    }
    
    private var indicatorsView: some View {
        HStack(alignment: .center, spacing: getWidth() * 0.05) {
            AudienceIndicatorView(percentage: Int(viewModel.indicators.audience))
                .padding(.bottom)

            ChaosIndicatorsView(
                illBeing: viewModel.indicators.illBeing,
                socioPoliticalInstability: viewModel.indicators.socioPoliticalInstability,
                environmentalDegradation: viewModel.indicators.environmentalDegradation,
                year: String(viewModel.indicators.currentYear)
            )
        }
    }
}
