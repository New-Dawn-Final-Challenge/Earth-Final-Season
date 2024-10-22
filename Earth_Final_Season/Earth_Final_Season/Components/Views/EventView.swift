//
//  EventView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//
import SwiftUI

struct EventView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State var textToShow: String = ""
    
    let eventDescription: String
    let consequence1: String
    let consequence2: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: getWidth() * 0.8,
                   height: getHeight() * 0.12)
            .padding()
            .foregroundStyle(Color(UIColor.systemGray4))
            .shadow(color: Color.blue, radius: CGFloat(gameplayVM.mainScreenShadowRadius))
            .overlay(
                Text(textToShow)
                    .font(.bodyFont)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            )
            .onAppear(perform: updateText)
            .onChange(of: gameplayVM.currentState == .consequence, updateText)
    }

    func updateText() {
        if gameplayVM.currentState == .consequence {
            
            //ARRUMAR
            if gameplayVM.getLastChosenOption() == "choice1" {
                withAnimation {
                    textToShow = consequence1
                }
            }
            else {
                withAnimation {
                    textToShow = consequence2
                }
            }
        }
        else {
            withAnimation {
                textToShow = eventDescription
            }
        }
    }
}
