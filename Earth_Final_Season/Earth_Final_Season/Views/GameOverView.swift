//
//  GameOverView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI
import Design_System

struct GameOverView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var isPresented: Bool
    var doStuff: ()-> Void
    
    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: 12) {
                Spacer()
                
                gameOverTitle
                yearReachedText
                gameOverImage
                gameOverDescription(title: gameplayVM.getGameOverTitle() ?? "",
                                    description: gameplayVM.getGameOverReason() ?? "")
                gameOverButtons
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
    
    private var popUpBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: 1)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.black)
            )
    }
    
    private var gameOverTitle: some View {
        Text("Game Over")
            .font(.largeTitleFont)
            .foregroundStyle(Assets.Colors.alert.swiftUIColor)
            .shadow(color: Assets.Colors.alert.swiftUIColor,
                    radius: 3, x: -3, y: 3)
    }
    
    private var yearReachedText: some View {
        VStack {
            HStack(alignment: .bottom) {
                starView
                Text("New Record!")
                starView
            }
            
            Text("12 years")
        }
        .font(.title3Font)
        .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
        
//        Text("You ran the show for 12 years")
//            .font(.title3Font)
//            .foregroundStyle(Assets.Colors.accentPrimary.swiftUIColor)
//            .multilineTextAlignment(.center)
    }
    
    private var starView: some View {
        Image(systemName: "star.fill")
            .shadow(color: Assets.Colors.accentPrimary.swiftUIColor.opacity(0.6),
                    radius: 2, x: -2, y: 2)
    }
    
    private var gameOverImage: some View {
        ZStack {
            Assets.Images.eventsScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.8,
                       height: getHeight() * 0.14)
            
            Assets.Images.audienceEnd.swiftUIImage
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
        }
    }
    
    private func gameOverDescription(title: String, description: String) -> some View {
        VStack(spacing: 12) {
            Text(title)
                .shadow(color: .black, radius: 0.3, x: 0, y: 0)
            Text(description)
        }
        .fixedSize(horizontal: false, vertical: true)
        .font(.bodyFont)
        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
        .multilineTextAlignment(.center)
        .padding(35)
        .frame(width: getWidth() * 0.8,
               height: getHeight() * 0.4)
        .background(
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
        )
    }
    
    private func buttonView(label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .padding()
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 1)
                }
        }
        .padding(.horizontal)
        .font(.bodyFont)
    }
    
    private var gameOverButtons: some View {
        VStack(spacing: 12) {
            buttonView(label: "Play again") {
                gameplayVM.resetGame()
                isPresented.toggle()
            }
            
            buttonView(label: "Menu") {
                gameplayVM.resetGame()
                isPresented.toggle()
                doStuff()
            }
        }
    }
}

//struct GameOverView: View {
//    @Environment(GameplayViewModel.self) private var gameplayVM
//    @Binding var isPresented: Bool
//    @State private var trigger = false
//    @State private var opacity: Double = 0.0
//    var text = ""
//    
//    var body: some View {
//        VStack(alignment: .center) {
//            VStack(alignment: .center) {
//                
//                Spacer()
//                
//                GlitchTextEffect(text: "Game Over", intensity: Constants.GameOverView.glitchTextIntensity)
//                    .padding(.vertical)
//                HackerTextView(
//                    text: gameplayVM.getGameOverReason() ?? "",
//                    trigger: trigger,
//                    transition: .identity,
//                    speed: Constants.GameOverView.hackerTextSpeed
//                )
//                .fontDesign(.monospaced)
//                .lineLimit(Constants.GameOverView.hackerTextLineLimit)
//                .multilineTextAlignment(.center)
//                .font(.bodyFont)
//                .padding()
//                
//                Spacer()
//                
//            }
//            
//            Button("Restart") {
//                gameplayVM.resetGame()
//                isPresented = false
//            }
//            .padding()
//            .opacity(opacity)
//            .font(.title1Font)
//            .buttonStyle(.bordered)
//            .tint(.pink)
//            
//            Spacer()
//            
//        }
//        .task {
//            try? await Task.sleep(nanoseconds: Constants.GameOverView.buttonOpacityDelay)
//            trigger.toggle()
//            withAnimation(.easeInOut(duration: Constants.GameOverView.buttonAnimationDuration)) {
//                opacity = 1
//            }
//        }
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
