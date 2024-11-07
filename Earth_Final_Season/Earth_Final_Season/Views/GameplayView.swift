import SwiftUI
import Design_System

struct GameplayView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var settingsVM: SettingsViewModel
    @Binding var leaderboardVM: LeaderboardViewModel
    @Environment(\.dismiss) var dismiss
    
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
        .fullScreenCover(isPresented: $settingsVM.isPresented) {
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea(edges: .all)
                        SettingsModalView(vm: $settingsVM, doStuff: {
                            // voltar pra tela anterior
                            print("Dismissei!")
                            dismiss()
                        })
                            .frame(width: 400, height: 800)
                    }
                        .presentationBackground(.clear)
                }
        .navigationBarBackButtonHidden()
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .onChange(of: gameplayVM.getState()) {
            if gameplayVM.getState() == .gameOver {
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
            .padding(20)
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
        .padding(.top, Constants.GameplayView.paddingTopChoiceView)
        .opacity(gameplayVM.getState() == .consequence ? 0 : 1)
    }
    
    private func tapChoicesView(event: Event) -> some View {
        TapView(
            onChooseOption1: { gameplayVM.chooseOption(option: 1) },
            onChooseOption2: { gameplayVM.chooseOption(option: 2) },
            text1: event.choice1,
            text2: event.choice2
        )
        .padding(.top, Constants.GameplayView.paddingTopChoiceView)
        .opacity(gameplayVM.getState() == .consequence ? 0 : 1)
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
        .padding(.top, Constants.GameplayView.panelPaddingTop)
    }
    
    private var staticPanelView: some View {
        HStack {
            panelAccessoryA
            Spacer()
            panelAccessoryB
        }
        .padding(.horizontal, Constants.GameplayView.panelHorizontalPadding)
        .padding(.top, Constants.GameplayView.panelPaddingTop)
    }
    
    private var panelAccessoryA: some View {
        Assets.Images.panelAccessoryA.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.GameplayView.panelAccessoryWidthMultiplier,
                   height: getHeight() * Constants.GameplayView.panelAccessoryHeightMultiplier)
    }
    
    private var panelAccessoryB: some View {
        Assets.Images.panelAccessoryB.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.GameplayView.panelAccessoryWidthMultiplier,
                   height: getHeight() * Constants.GameplayView.panelAccessoryHeightMultiplier)
    }
    
    // MARK: - Helper Methods
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
            helperButton(destination: EmptyView(), imageName: "questionmark")
            
            Button {
                settingsVM.isPresented.toggle()
            } label: {
                HelperButtonView(imageName: "gearshape.fill")
            }
        }
        .padding(.trailing, Constants.GameplayView.helperButtonsPaddingTrailing)
        .padding(.top, Constants.GameplayView.helperButtonsPaddingTop)
    }
    
    private func helperButton<Destination: View>(destination: Destination, imageName: String) -> some View {
        NavigationLink(destination: destination) {
            HelperButtonView(imageName: imageName)
        }
    }
    
    private var indicatorsView: some View {
        HStack(alignment: .center, spacing: getWidth() * Constants.GameplayView.indicatorSpacingMultiplier) {
            AudienceIndicatorView(percentage: CGFloat(Int(gameplayVM.getIndicators()?.audience ?? 0)))
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
