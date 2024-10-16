import SwiftUI

struct GameplayView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Environment(ChaosIndicatorsViewModel.self) private var chaosIndicatorsVM
    //@Environment(GameEngine.self) private var gameEngine
    @Binding var settingsVM: SettingsViewModel
    
    @State private var showGameOver = false
    
    var body: some View {
        VStack(spacing: 6) {
            helperButtonsView
            
            indicatorsView
            
            if let event = gameplayVM.getEvent() {

                // Change image to current image
                CharacterView(characterImage: "image1", characterName: event.character)
                
                EventView(eventDescription: event.description,
                          consequence1: event.consequenceDescription1,
                          consequence2: event.consequenceDescription2
                )

                VStack(spacing: -20) {
                    ChoicesView(shadowRadius: gameplayVM.option1ShadowRadius,
                                 text: event.choice1)
                    .padding(.trailing, 100)

                    ChoicesView(shadowRadius: gameplayVM.option2ShadowRadius,
                                 text: event.choice2)
                    .padding(.leading, 100)
                }
                .padding(.top, -15)
                // Hide the choices to focus on the consequence
                .opacity(gameplayVM.currentState == .consequence ? 0 : 1)
            } else {
                Text("No more events")
                    .font(.title)
                    .padding()
            }
            
            SliderView(
                onChooseOption1: {
                    gameplayVM.chooseOption1()
                },
                onChooseOption2: {
                    gameplayVM.chooseOption2()
                }
            )
            
            Spacer()
        }
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .onChange(of: gameplayVM.currentState == .gameOver) {
            showGameOver = gameplayVM.currentState == .gameOver
        }
        .onChange(of: gameplayVM.currentState) {
            //muda e proca o timer
            
            
        }
        .navigationDestination(isPresented: $showGameOver) {
            GameOverView(isPresented: $showGameOver)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                HelpButtonView()
            }
            
            NavigationLink(destination: SettingsView(settingsVM: $settingsVM)) {
                SettingsButtonView()
            }
        }
        .padding(.trailing)
    }
    
    private var indicatorsView: some View {
        HStack(alignment: .center, spacing: getWidth() * 0.05) {
            AudienceIndicatorView(percentage: Int(gameplayVM.getIndicators()?.audience ?? 0))
                .padding(.bottom)

            ChaosIndicatorsView(
                illBeing: gameplayVM.getIndicators()?.illBeing ?? 0,
                socioPoliticalInstability: gameplayVM.getIndicators()?.socioPoliticalInstability ?? 0,
                environmentalDegradation: gameplayVM.getIndicators()?.environmentalDegradation ?? 0,
                year: String(gameplayVM.getIndicators()?.currentYear ?? 0)
            )
        }
    }
}
