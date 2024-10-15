//
//  ChaosIndicatorsValueChangeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 07/10/24.
//

import SwiftUI

struct ChaosIndicatorsValueChangeView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Environment(GameEngine.self) private var gameEngine
    @State private var chaosIndicatorsValueChangeVM: ChaosIndicatorsValueChangeViewModel
    
    let indicator: String

    init(gameplayVM: GameplayViewModel, gameEngine: GameEngine, indicator: String) {
        _chaosIndicatorsValueChangeVM = State(initialValue: ChaosIndicatorsValueChangeViewModel(gameplayVM: gameplayVM, gameEngine: gameEngine, indicator: indicator))
        self.indicator = indicator
    }

    var body: some View {
        HStack() {
            Image(systemName: chaosIndicatorsValueChangeVM.valueIsIncreasing ? "arrowshape.up.fill" : "arrowshape.down.fill")
            Text(String(chaosIndicatorsValueChangeVM.value))
        }
        .foregroundStyle(chaosIndicatorsValueChangeVM.valueIsIncreasing ? .orange : .cyan)
        .opacity(chaosIndicatorsValueChangeVM.shouldShowIndicator ? 1 : 0)
        .scaleEffect(chaosIndicatorsValueChangeVM.scaleChange, anchor: .bottom)
        .onChange(of: gameEngine.state == .consequence) {
            withAnimation(Animation.linear(duration: 1)) {
                chaosIndicatorsValueChangeVM.getIndicatorValue()
            }
        }
    }
}
