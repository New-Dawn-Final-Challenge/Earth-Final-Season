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
            
            VStack() {
                helperButtonsView
                gameContentView
                controlPanelView
            }
            .padding(.top, 80)
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
                VStack(spacing: -6) {
                    CharacterView(characterImage: "image1", characterName: event.character)
                    EventView(eventDescription: event.description,
                              consequence1: event.consequenceDescription1,
                              consequence2: event.consequenceDescription2)
                    choiceView(for: event)
                }
            } else {
                noMoreEventsView
            }
        }
        .padding(.bottom, -12)
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
        .opacity(gameplayVM.currentState == .consequence ? 0 : 1)
    }
    
    private func tapChoicesView(event: Event) -> some View {
        TapView(
            onChooseOption1: { gameplayVM.chooseOption(option: 1) },
            onChooseOption2: { gameplayVM.chooseOption(option: 2) },
            text1: event.choice1,
            text2: event.choice2
        )
        .padding(.top, Constants.GameplayView.paddingTopChoiceView)
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
        .padding(.top, Constants.GameplayView.panelPaddingTop)
    }
    
    private var panelBackground: some View {
        Rectangle()
            .edgesIgnoringSafeArea(.all)
            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            .frame(width: getWidth() * 1,
                   height: getHeight() * Constants.BlackPanel.backgroundPanelHeight)
    }
    
    private var controlPanelView: some View {
        VStack {
            Spacer()
            
            ZStack {
                panelBackground
                
                VStack(alignment: .center) {
                    topPanelView
                        .padding(.bottom, -20)
                    
                    ZStack {
                        bottomPanelView
                        actionControlsView
                            .padding(.bottom, 40)
                    }
                }
                .padding(.bottom, Constants.BlackPanel.bottomPadding)
            }
        }
    }
    
    private var topPanelView: some View {
        HStack(spacing: Constants.BlackPanel.horizontalSpacing) {
            blackPanelItemView(Assets.Images.leftBlackPanel.swiftUIImage,
                               widthMultiplier: Constants.BlackPanel.sidePanelWidth,
                               padding: Constants.BlackPanel.sidePanelPadding)
            
            ZStack {
                blackPanelItemView(Assets.Images.yearBlackPanel.swiftUIImage,
                                   widthMultiplier: Constants.BlackPanel.yearPanelWidth)
                yearView
            }
            
            ZStack {
                blackPanelItemView(Assets.Images.indicatorsBlackPanel.swiftUIImage,
                                   widthMultiplier: Constants.BlackPanel.indicatorPanelWidth)
                indicatorsView
            }
            
            blackPanelItemView(Assets.Images.rightBlackPanel.swiftUIImage,
                               widthMultiplier: Constants.BlackPanel.sidePanelWidth,
                               padding: Constants.BlackPanel.sidePanelPadding)
        }
    }
    
    private var yearView: some View {
        Assets.Images.yearScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.BlackPanel.yearMonitorWidth,
                   height: getHeight() * Constants.BlackPanel.yearMonitorHeight)
            .padding(.leading, Constants.BlackPanel.yearMonitorPadding)
            .overlay(
                Text("Year\n\(gameplayVM.getIndicators()?.currentYear ?? 0)")
                    .font(.title3Font)
                    .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .padding(.leading, Constants.BlackPanel.yearMonitorPadding)
            )
    }
    
    private var bottomPanelView: some View {
        blackPanelItemView(Assets.Images.draggerBlackPanel.swiftUIImage,
                           widthMultiplier: Constants.BlackPanel.bottomPanelWidth)
    }
    
    private func blackPanelItemView(_ image: Image, widthMultiplier: CGFloat, padding: CGFloat? = nil) -> some View {
        image
            .resizable()
            .frame(width: getWidth() * widthMultiplier,
                   height: getHeight() * Constants.BlackPanel.panelHeight)
            .padding(.horizontal, padding ?? 0)
    }
    
    private var staticPanelView: some View {
        HStack {
            Assets.Images.accessibilityPanel.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.GameplayView.staticPanelWidth,
                       height: getHeight() * Constants.GameplayView.staticPanelHeight)
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
            helperButton(destination: SettingsView(settingsVM: $settingsVM), imageName: "questionmark")
            helperButton(destination: MenuView(), imageName: "house.fill")
            helperButton(destination: SettingsView(settingsVM: $settingsVM), imageName: "gearshape.fill")
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
            
            ChaosIndicatorsView(
                illBeing: gameplayVM.getIndicators()?.illBeing ?? 0,
                socioPoliticalInstability: gameplayVM.getIndicators()?.socioPoliticalInstability ?? 0,
                environmentalDegradation: gameplayVM.getIndicators()?.environmentalDegradation ?? 0
            )
        }
    }
}
