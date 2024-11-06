import SwiftUI
import Design_System

struct GameplayView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var settingsVM: SettingsViewModel
    @Binding var leaderboardVM: LeaderboardViewModel
    
    @State private var showGameOver = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: -10) {
                helperButtonsView
                indicatorsView
                gameContentView
                actionControlsView
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .onChange(of: gameplayVM.currentState) {
            if gameplayVM.currentState == .gameOver {
                Task {
                    showGameOver = true
                    await leaderboardVM.submitScore(scoreToSubmit: gameplayVM.getIndicators()?.currentYear ?? 0)
                }
            }
        }
        .navigationDestination(isPresented: $showGameOver) {
            GameOverView(isPresented: $showGameOver)
        }
    }
    
    // MARK: - View Components
    
    private var gameContentView: some View {
        Group {
            if let event = gameplayVM.getEvent() {
                CharacterView(characterImage: "image1", characterName: event.character)
                EventView(eventDescription: event.description,
                          consequence1: event.consequenceDescription1,
                          consequence2: event.consequenceDescription2)
                choiceView(for: event)
            } else {
                noMoreEventsView
            }
        }
    }
    
    private var noMoreEventsView: some View {
        Text("No more events")
            .font(.title)
            .padding()
    }
    
    private func choiceView(for event: Event) -> some View {
        switch settingsVM.selectedGesture {
        case .holdDrag:
            return AnyView(holdDragChoicesView(event: event))
        case .tap:
            return AnyView(tapChoicesView(event: event))
        }
    }
    
    private func holdDragChoicesView(event: Event) -> some View {
        VStack(spacing: -30) {
            ChoicesView(shadowRadius: gameplayVM.option1ShadowRadius,
                        text: event.choice1,
                        image: Assets.Images.optionScreen2.swiftUIImage)
                .padding(.trailing, 130)
            
            ChoicesView(shadowRadius: gameplayVM.option2ShadowRadius,
                        text: event.choice2,
                        image: Assets.Images.optionScreen1.swiftUIImage)
                .padding(.leading, 130)
        }
        .padding(.top, -15)
        .opacity(gameplayVM.currentState == .consequence ? 0 : 1)
    }
    
    private func tapChoicesView(event: Event) -> some View {
        TapView(
            onChooseOption1: { gameplayVM.chooseOption(option: 1) },
            onChooseOption2: { gameplayVM.chooseOption(option: 2) },
            text1: event.choice1,
            text2: event.choice2
        )
        .padding(.top, -15)
        .opacity(gameplayVM.currentState == .consequence ? 0 : 1)
    }
    
    private var actionControlsView: some View {
        Group {
            if settingsVM.selectedGesture == .holdDrag {
                sliderControlView
            } else {
                staticPanelView
            }
        }
    }
    
    private var sliderControlView: some View {
        HStack {
            panelAccessoryA
            SliderView(
                onChooseOption1: { gameplayVM.chooseOption(option: 1) },
                onChooseOption2: { gameplayVM.chooseOption(option: 2) }
            )
            panelAccessoryB
        }
        .padding(.top, 30)
    }
    
    private var staticPanelView: some View {
        HStack {
            panelAccessoryA
            Spacer()
            panelAccessoryB
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
    
    private var panelAccessoryA: some View {
        Assets.Images.panelAccessoryA.swiftUIImage
            .resizable()
            .frame(width: getWidth() * 0.3, height: getHeight() * 0.08)
    }
    
    private var panelAccessoryB: some View {
        Assets.Images.panelAccessoryB.swiftUIImage
            .resizable()
            .frame(width: getWidth() * 0.3, height: getHeight() * 0.08)
    }
    
    // MARK: - Helper Methods
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
            helperButton(destination: SettingsView(settingsVM: $settingsVM), imageName: "questionmark")
            helperButton(destination: MenuView(), imageName: "house.fill")
            helperButton(destination: SettingsView(settingsVM: $settingsVM), imageName: "gearshape.fill")
        }
        .padding(.trailing, 50)
        .padding(.top, 32)
    }
    
    private func helperButton<Destination: View>(destination: Destination, imageName: String) -> some View {
        NavigationLink(destination: destination) {
            HelperButtonView(imageName: imageName)
        }
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
