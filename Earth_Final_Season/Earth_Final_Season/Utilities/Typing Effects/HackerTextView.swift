//
//  HackerTextView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 23/10/24.
//

import SwiftUI

struct HackerTextView: View {
    var text: String
    var trigger: Bool
    var transition: ContentTransition = .interpolate
    var duration: CGFloat = 1
    var speed: CGFloat = 0.1
    @State private var animatedText = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklnmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()/?[]{};:=+-"
        return Array(string)
    }()
    @State private var animationID: String = UUID().uuidString
    var body: some View {
        Text(animatedText)
            .fontDesign(.monospaced)
            .truncationMode(.tail)
            .contentTransition(transition)
            .animation(.easeInOut(duration: 0.1), value: animatedText)
            .onAppear {
                guard animatedText.isEmpty else { return }
                setRandomCharacters()
            }
            .customOnChange(value: trigger) { newValue in
                animateText()
            }
            .customOnChange(value: text) { newValue in
                animatedText = text
                animationID = UUID().uuidString
                setRandomCharacters()
                animateText()
            }
    }
    
    private func animateText() {
        let currentID = animationID
        for index in text.indices {
            let delay = CGFloat.random(in: 0...duration)
            var timerDuration = 0.0
            let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
                if currentID != animationID {
                    timer.invalidate()
                } else {
                    timerDuration += speed
                    if timerDuration >= delay {
                        if text.indices.contains(index) {
                            let actualCharacter = text[index]
                            replaceCharacter(at: index, character: actualCharacter)
                        }
                    } else {
                        guard let randomCharacter = randomCharacters.randomElement() else { return }
                        replaceCharacter(at: index, character: randomCharacter)
                    }
                }
            }
            timer.fire()
        }
    }
    
    private func setRandomCharacters() {
        animatedText = text
        for index in animatedText.indices {
            guard let randomCharacter = randomCharacters.randomElement() else { return }
            replaceCharacter(at: index, character: randomCharacter)
        }
    }
    
    func replaceCharacter(at index: String.Index, character: Character) {
        guard animatedText.indices.contains(index) else { return }
        let indexCharacter = String(animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            animatedText.replaceSubrange(index...index, with: String(character))
        }
    }
}

fileprivate extension View {
    @ViewBuilder
    func customOnChange<T: Equatable>(value: T, result: @escaping (T) -> ()) -> some View {
        if #available(iOS 17, *) {
            self.onChange(of: value) { oldValue, newValue in
                result(newValue)
            }
        } else {
            self.onChange(of: value, perform:  { value in
                result(value)
            })
        }
    }
}

private struct Exampleview: View {
    @State private var trigger = false
    @State private var opacity: Double = 0
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            GlitchTextEffect(text: "Game Over", intensity: 2)
                .font(.largeTitle)
                .padding()
            
            VStack {

                HackerTextView(text: "Crossed the road without looking at both sides",
                               trigger: trigger,
                               transition: .identity,
                               speed: 0.001
                               )
            }
            .lineLimit(3)
            .font(.largeTitle)
            .padding()
            Spacer()
            
            Button("Play Again") {
                    
            }
            .opacity(opacity)
            .font(.title)
            .buttonStyle(.bordered)
            .tint(.pink)
            
            Spacer()

            
        }
        .task {
            try? await Task.sleep(nanoseconds: 4500000000)
            trigger.toggle()
            withAnimation(.easeInOut(duration: 4.5)) {
                opacity = 1
            }
        }
    }
}

#Preview {
    Exampleview()
}
