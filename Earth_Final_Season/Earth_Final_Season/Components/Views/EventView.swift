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
        Assets.Images.eventsScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.EventView.frameWidthMultiplier,
                   height: getHeight() * Constants.EventView.frameHeightMultiplier)
            .padding()
            .foregroundStyle(Color(UIColor.systemGray4))
            .overlay(
                Group {
                    if textToShow == eventDescription {
                        Text(formatText(textToShow))
                    } else {
                        HackerTextView(text: formatText(textToShow), speed: 0.05)
                    }
                }
                .font(.bodyFont)
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Constants.EventView.horizontalPadding)
            )
            .onAppear(perform: updateText)
            .onChange(of: gameplayVM.getState() == .consequence, updateText)
    }

    func updateText() {
        guard gameplayVM.getState() != .choosing else {
            withAnimation {
                textToShow = eventDescription
            }
            return
        }
        guard case gameplayVM.getLastChosenOption() = "choice1" else {
            withAnimation {
                textToShow = consequence2
            }
            return
        }
        withAnimation {
            textToShow = consequence1
        }
    }
    
    func formatText(_ text: String) -> String {
        var formattedText = text
        let ponctuation = [".", "?", "!", ":"]
        if (text.count < 1) { return "" }
        
        if (!ponctuation.contains(text.last!.lowercased())) {
            formattedText.append(".")
        }
        return formattedText
    }
}


#Preview {
    EventView(eventDescription: "Event description here", consequence1: "Consequence 1", consequence2: "Consequence 2")
}
