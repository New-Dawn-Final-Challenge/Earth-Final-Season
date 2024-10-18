//
//  ChaosIndicatorsValueChangeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 07/10/24.
//

import SwiftUI

struct ChaosIndicatorsValueChangeView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM

    let indicator: String
    
    let nIndicator: Int

    init(indicator: String, nIndicator: Int) {
        self.indicator = indicator
        self.nIndicator = nIndicator
    }

    var body: some View {
        HStack() {
            Image(systemName: gameplayVM.valueIsIncreasing[nIndicator] ?
                  "arrowshape.up.fill" : "arrowshape.down.fill")
            Text(String(gameplayVM.value[nIndicator]))
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
