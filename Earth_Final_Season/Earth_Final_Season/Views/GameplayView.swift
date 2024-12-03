import SwiftUI
import Design_System
import Toast

struct GameplayView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var settingsVM: SettingsViewModel
    @Binding var leaderboardVM: LeaderboardViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showGameOver = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: -4) {
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
        .fullScreenCover(isPresented: $settingsVM.isPresentedHelp) {
            ZStack {
                Color.black.opacity(0.6).ignoresSafeArea(edges: .all)
                HelpScreen(vm: $settingsVM)
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
                    SoundtrackAudioManager.shared.crossfadeToNewSoundtrack(named: "menu", duration: 0.5)
                })
            }
            .presentationBackground(.clear)
        }
        .onChange(of: gameplayVM.unlockedCharacterCount) {
            if let newCharacterName = gameplayVM.getUnlockedCharacters().last,
               let newCharacter = CharacterGallery.allCases.first(where: { $0.name(isPortuguese: false).lowercased() == newCharacterName.lowercased() }) {
                showToast(character: newCharacter, gameplayVM: gameplayVM)
            }
        }
        .onChange(of: gameplayVM.unlockedEndingsCount) {
            if let newEnding = gameplayVM.getUnlockedEndings().last,
               let newEnding = EndingsGallery.allCases.first(where: { $0.ending.lowercased() == newEnding.lowercased() }) {
                showNewEndingToast(ending: newEnding, gameplayVM: gameplayVM)
            }
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
        Text(gameplayVM.isPortuguese ? "Sem mais eventos" : "No more events")
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
            helperButton(imageName: "questionmark")
            
            Button {
                settingsVM.isPresentedinGameplay.toggle()
            } label: {
                HelperButtonView(imageName: "gearshape.fill")
            }
        }
        .padding(.trailing, Constants.GameplayView.helperButtonsPaddingTrailing)
        .padding(.top, Constants.GameplayView.helperButtonsPaddingTop)
    }
    
    private func helperButton(imageName: String) -> some View {
        Button {
            settingsVM.isPresentedHelp.toggle()
        } label: {
            HelperButtonView(imageName: imageName)
        }
    }
    
    func showNewEndingToast(ending: EndingsGallery, gameplayVM: GameplayViewModel) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        // Create a new window specifically for the toast
        let toastWindow = UIWindow(windowScene: scene)
        toastWindow.windowLevel = .alert + 1 // Ensure it's above all other windows
        toastWindow.backgroundColor = .clear

        let toastView = toastEndingView(ending: ending, gameplayVM: gameplayVM)
        let hostingController = UIHostingController(rootView: toastView)
        hostingController.view.backgroundColor = .clear
        
        // Configure the initial position and size of the toast
        let initialYPosition: CGFloat = -100
        hostingController.view.frame = CGRect(x: 0, y: initialYPosition, width: toastWindow.bounds.width, height: 100)
        hostingController.view.alpha = 0.0

        toastWindow.rootViewController = UIViewController()
        toastWindow.rootViewController?.view.addSubview(hostingController.view)
        toastWindow.makeKeyAndVisible()

        // Animate the toast appearance and disappearance
        UIView.animate(withDuration: 0.5, animations: {
            hostingController.view.alpha = 1.0
            hostingController.view.frame.origin.y += 100
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                UIView.animate(withDuration: 0.5, animations: {
                    hostingController.view.alpha = 0.0
                    hostingController.view.frame.origin.y -= 100
                }, completion: { _ in
                    hostingController.view.removeFromSuperview()
                    toastWindow.isHidden = true // Hide and remove the toast window
                })
            }
        })
    }
    
    func showToast(character: CharacterGallery, gameplayVM: GameplayViewModel) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let toastView = toastCharacterView(character: character, gameplayVM: gameplayVM)
            let hostingController = UIHostingController(rootView: toastView)
            hostingController.view.backgroundColor = .clear
            
            let initialYPosition: CGFloat = -100 + 20
            hostingController.view.frame = CGRect(x: 0, y: initialYPosition, width: window.bounds.width, height: 100)
            hostingController.view.alpha = 0.0

            window.addSubview(hostingController.view)
            
            // Animate the toast appearance and disappearance
            UIView.animate(withDuration: 0.5, animations: {
                hostingController.view.alpha = 1.0
                hostingController.view.frame.origin.y += 100
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    UIView.animate(withDuration: 0.5, animations: {
                        hostingController.view.alpha = 0.0
                        hostingController.view.frame.origin.y -= 100
                    }, completion: { _ in
                        hostingController.view.removeFromSuperview()
                    })
                }
            })
        }
    }

    func toastCharacterView(character: CharacterGallery, gameplayVM: GameplayViewModel) -> some View {
        HStack(spacing: 16) {
            character.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))

            VStack(alignment: .leading) {
                Text(gameplayVM.isPortuguese ? "Novo Personagem Desbloqueado!" : "New Character Unlocked!")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(character.name(isPortuguese: gameplayVM.isPortuguese).capitalized)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                    .cornerRadius(12)
            }
        )
        .cornerRadius(12)
        .shadow(radius: 4)
    }

    func toastEndingView(ending: EndingsGallery, gameplayVM: GameplayViewModel) -> some View {
        HStack(spacing: 16) {
            ending.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))

            VStack(alignment: .leading) {
                Text(gameplayVM.isPortuguese ? "Novo Final Desbloqueado!" : "New Ending Unlocked!")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(ending.displayTranslated(isPortuguese: gameplayVM.isPortuguese).capitalized)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                    .cornerRadius(12)
            }
        )
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
