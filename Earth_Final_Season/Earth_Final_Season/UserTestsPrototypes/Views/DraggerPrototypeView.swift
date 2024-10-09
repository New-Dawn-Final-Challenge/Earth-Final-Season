//
//  DraggerPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import SwiftUI

// Essa struct nao conforma a nossa arquitetura, mas é
// Apenas um protótipo antigo usado para testes. Optamos por deixar assim
struct DraggerPrototypeView: View {
    @StateObject private var viewModel = DraggerPrototypeViewModel()

    var body: some View {
        VStack {
            MainScreenView(optionToChoose: $viewModel.optionToChoose,
                           mainScreenShadowRadius: $viewModel.mainScreenShadowRadius)
            
            OptionButton(shadowRadius: $viewModel.optionAShadowRadius, text: "This is option A",
                         action: {
                             viewModel.selectOptionA()
                         })
            .padding(.trailing, 100)
            
            OptionButton(shadowRadius: $viewModel.optionBShadowRadius, text: "This is option B",
                         action: {
                             viewModel.selectOptionB()
                         })
            .padding(.leading, 100)

            TestSliderView(
                optionToChoose: $viewModel.optionToChoose,
                mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                optionAShadowRadius: $viewModel.optionAShadowRadius,
                optionBShadowRadius: $viewModel.optionBShadowRadius
            )
        }
        .onAppear(perform: HapticsManager.shared.prepareHaptics)
    }
}

#Preview {
    DraggerPrototypeView()
}
