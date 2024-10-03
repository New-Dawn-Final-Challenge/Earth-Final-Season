//
//  EventView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 24/09/24.
//
import SwiftUI

struct EventView: View {
    @Binding var mainScreenShadowRadius: Int
    @EnvironmentObject var viewModel: GameplayViewModel
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
            .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
            .overlay(
                Text(textToShow)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding()
            )
            .onAppear(perform: updateText)
            .onChange(of: viewModel.isShowingConsequence, updateText)
    }

    func updateText() {
        if viewModel.isShowingConsequence {
            if viewModel.lastChosenOption == "choice1" {
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
