import SwiftUI
import Design_System

struct GameplayView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var settingsVM: SettingsViewModel
    @Binding var leaderboardVM: LeaderboardViewModel
    
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
                switch (settingsVM.selectedGesture) {
                case .holdDrag:
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
                case .tap:
                    TapView(onChooseOption1:  {
                        gameplayVM.chooseOption(option: 1)
                    },
                            onChooseOption2: {
                        gameplayVM.chooseOption(option: 2)
                    },
                            text1: event.choice1,
                            text2: event.choice2
                    )
                    .opacity(gameplayVM.currentState == .consequence ? 0 : 1)
                }
            } else {
                Text("No more events")
                    .font(.title)
                    .padding()
            }
            
            if (settingsVM.selectedGesture == .holdDrag) {
                SliderView(
                    onChooseOption1: {
                        gameplayVM.chooseOption(option: 1)
                    },
                    onChooseOption2: {
                        gameplayVM.chooseOption(option: 2)
                    }
                )
                Spacer()
            }
            
        }
        .background(
            Assets.Colors.bgFillPrimary.swiftUIColor
        )
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .onChange(of: gameplayVM.currentState == .gameOver) {
            Task {
                showGameOver = gameplayVM.currentState == .gameOver
                await leaderboardVM.submitScore(scoreToSubmit: gameplayVM.getIndicators()?.currentYear ?? 0)
            }
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
            
            NavigationLink(destination: MenuView()) {
                MenuButtonView()
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
