//
//  ChaosIndicatorsValueChangeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 07/10/24.
//

import SwiftUI
import Design_System

struct ChaosIndicatorsValueChangeView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM

    let indicator: String
    
    let nIndicator: Int

    init(indicator: String, nIndicator: Int) {
        self.indicator = indicator
        self.nIndicator = nIndicator
    }

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: gameplayVM.valueIsIncreasing[nIndicator] ?
                  "arrowshape.up.fill" : "arrowshape.down.fill")
                .resizable()
                .frame(width: getWidth() * 0.03,
                       height: getHeight() * 0.015)
            Text(String(gameplayVM.value[nIndicator]))
                .font(.footnoteFont)
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(gameplayVM.valueIsIncreasing[nIndicator] ? .orange : .cyan)
        .opacity(gameplayVM.shouldShowIndicator[nIndicator] ? 1 : 0)
        .scaleEffect(gameplayVM.scaleChange[nIndicator], anchor: .bottom)
        .onChange(of: gameplayVM.currentState) {
            withAnimation(Animation.linear(duration: 1)) {
                gameplayVM.getIndicatorValue(indicator: indicator, nIndicator: nIndicator)
            }
        }
    }
}
