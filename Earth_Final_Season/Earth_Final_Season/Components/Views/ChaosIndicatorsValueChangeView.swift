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
    
    let n_indicator: Int
    
    init(indicator: String, n_indicator: Int) {
        self.indicator = indicator
        self.n_indicator = n_indicator
    }

    var body: some View {
        HStack() {
            Image(systemName: gameplayVM.valueIsIncreasing[n_indicator] ? "arrowshape.up.fill" : "arrowshape.down.fill")
            Text(String(gameplayVM.value[n_indicator]))
        }
        .foregroundStyle(gameplayVM.valueIsIncreasing[n_indicator] ? .orange : .cyan)
        .opacity(gameplayVM.shouldShowIndicator[n_indicator] ? 1 : 0)
        .scaleEffect(gameplayVM.scaleChange[n_indicator], anchor: .bottom)
        .onChange(of: gameplayVM.currentState) {
            withAnimation(Animation.linear(duration: 1)) {
                gameplayVM.getIndicatorValue(indicator: indicator, n_indicator: n_indicator)
            }
        }
    }
}
