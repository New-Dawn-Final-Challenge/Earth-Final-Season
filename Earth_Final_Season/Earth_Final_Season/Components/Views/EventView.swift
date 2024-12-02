//
//  EventView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//

import SwiftUI
import Design_System

struct EventView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State var textToShow: String = ""
    
    let eventDescription: String
    let consequence1: String
    let consequence2: String
    
    var body: some View {
        ZStack {
            Assets.Images.eventsScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.EventView.frameWidthMultiplier,
                       height: getHeight() * Constants.EventView.frameHeightMultiplier)
                .padding()
                .foregroundStyle(Color(UIColor.systemGray4))
                .overlay(
                    Group {
                        if textToShow == eventDescription {
                            Text(textToShow)
                        } else {
                            HackerTextView(text: textToShow, speed: 0.05)
                        }
                    }
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Constants.EventView.horizontalPadding)
                )
                .onAppear(perform: updateText)
                .onChange(of: gameplayVM.getState() == .consequence, updateText)
                .onChange(of: gameplayVM.isGameReset) { updateText() }
            
            if gameplayVM.getState() == .consequence {
                ProgressBarView()
                    .offset(y: 60)
            }
        }
    }

    func updateText() {
        if gameplayVM.getState() == .choosing {
            withAnimation {
                textToShow = eventDescription
            }
        } else if gameplayVM.getState() == .consequence {
            if gameplayVM.getLastChosenOption() == "choice1" {
                withAnimation {
                    textToShow = consequence1
                }
            } else {
                withAnimation {
                    textToShow = consequence2
                }
            }
        }
        
        gameplayVM.isGameReset = false
    }
}

#Preview {
    EventView(eventDescription: "Event description here", consequence1: "Consequence 1", consequence2: "Consequence 2")
}
