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
            
            VStack(spacing: 0) {
                helperButtonsView
                    .padding(.top, 16)
                gameContentView
                ControlPanelView(settingsVM: $settingsVM)
            }
        }
        .fullScreenCover(isPresented: $settingsVM.isPresentedinGameplay) {
            ZStack {
                Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                SettingsModalView(vm: $settingsVM, text: "Game play Settings", doStuff: {
                    SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "menu", duration: 1.0)
                    dismiss()
                })
            }
            .presentationBackground(.clear)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                await leaderboardVM.getLocalPlayerHighestScore()
            }
        }
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
        .onAppear {
            SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "gameplay", duration: 1.0)
        }
        .onChange(of: gameplayVM.getState()) {
            if gameplayVM.getState() == .gameOver {
                Task {
                    showGameOver = true
                    await leaderboardVM.submitScore(scoreToSubmit: gameplayVM.getIndicators()?.currentYear ?? 0)
                }
            }
        }
        .fullScreenCover(isPresented: $showGameOver) {
            ZStack {
                Color.black.opacity(0.6).ignoresSafeArea(.all)
                GameOverView(isPresented: $showGameOver, leaderboardVM: $leaderboardVM, doStuff: {
                    dismiss()
                })
            }
            .presentationBackground(.clear)
        }

    }
    
    // MARK: - View Components
    
    private var gameContentView: some View {
        Group {
            if let event = gameplayVM.getEvent() {
                CharacterView(character: event.character)
                EventView(eventDescription: event.description,
                          consequence1: event.consequenceDescription1,
                          consequence2: event.consequenceDescription2)
                choiceView(for: event)
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
    
    // MARK: - Helper Methods
    
    private var helperButtonsView: some View {
        HStack {
            Spacer()
//            helperButton(destination: EmptyView(), imageName: "questionmark")
            
            Button {
                settingsVM.isPresentedinGameplay.toggle()
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
}
