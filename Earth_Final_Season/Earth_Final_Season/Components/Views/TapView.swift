//
//  TapView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 21/10/24.
//

import SwiftUI
import Design_System

struct TapView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State private var shadowRadius1 = 0
    @State private var shadowRadius2 = 0
    
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void
    var text1: String
    var text2: String
    var desiredOffset: Float = 28.0
    
    var body: some View {
        VStack(alignment: .center, spacing: -30) {
            createOptionButton(
                text: text1,
                shadowRadius: $shadowRadius1,
                edge: .trailing,
                paddingValue: 130,
                onChoose: onChooseOption1,
                optionIndex: 1
            )
            
            createOptionButton(
                text: text2,
                shadowRadius: $shadowRadius2,
                edge: .leading,
                paddingValue: 130,
                onChoose: onChooseOption2,
                optionIndex: 2
            )
        }
    }
    
    // MARK: - UI Helpers
    
    private func createOptionButton(text: String, shadowRadius: Binding<Int>, edge: Edge.Set, paddingValue: CGFloat, onChoose: @escaping () -> Void, optionIndex: Int) -> some View {
        Button(action: {
            onChoose()
            resetAllShadows()
        }) {

            let buttonImage: Image = optionIndex == 1 ?
                Assets.Images.optionScreen2.swiftUIImage : Assets.Images.optionScreen1.swiftUIImage

            buttonImage
                .resizable()
                .frame(width: getWidth() * 0.8, height: getHeight() * 0.12)
                .padding()
                .overlay(
                    Text(text)
                        .font(.bodyFont)
                        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                        .padding(.horizontal, 50)
                )
                .shadow(color: shadowColor(for: shadowRadius.wrappedValue), radius: CGFloat(shadowRadius.wrappedValue))
                .padding(edge, paddingValue)
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.1).onEnded { _ in
                updateShadowRadius(for: optionIndex)
            }
        )
    }

    private func shadowColor(for radius: Int) -> Color {
        radius > 0 ? Assets.Colors.secondaryGreen.swiftUIColor : Color.clear
    }
    
    // MARK: - Shadow Handling
    
    private func updateShadowRadius(for option: Int) {
        shadowRadius1 = option == 1 ? 18 : 0
        shadowRadius2 = option == 2 ? 18 : 0
        resetIndicatorsShadows()
        checkOptionIndicators(option)
    }
    
    private func resetAllShadows() {
        shadowRadius1 = 0
        shadowRadius2 = 0
        resetIndicatorsShadows()
        HapticsManager.shared.complexSuccess()
    }
    
    // MARK: - Option Indicators
    
    private func checkOptionIndicators(_ option: Int) {
        guard let options = gameplayVM.getEvent() else { return }
        
        let eD = [options.environmentalDegradation1, options.environmentalDegradation2]
        let iB = [options.illBeing1, options.illBeing2]
        let sI = [options.socioPoliticalInstability1, options.socioPoliticalInstability2]
        
        updateIndicatorShadow(for: eD, indicator: "environmentalDegradation", option: option)
        updateIndicatorShadow(for: iB, indicator: "illBeing", option: option)
        updateIndicatorShadow(for: sI, indicator: "socioPoliticalInstability", option: option)
    }

    private func updateIndicatorShadow(for values: [Int?], indicator: String, option: Int) {
        guard let value = values[option - 1], value != 0 else { return }
        
        switch indicator {
        case "environmentalDegradation":
            gameplayVM.environmentalDegradationShadowRadius = 14
        case "illBeing":
            gameplayVM.illBeingShadowRadius = 14
        case "socioPoliticalInstability":
            gameplayVM.sociopoliticalInstabilityShadowRadius = 14
        default:
            break
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = 0
        gameplayVM.illBeingShadowRadius = 0
        gameplayVM.sociopoliticalInstabilityShadowRadius = 0
    }
}
