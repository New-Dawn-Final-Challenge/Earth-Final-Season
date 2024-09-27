//
//  DraggerPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import SwiftUI

struct DraggerPrototypeView: View {
    @StateObject private var viewModel = DraggerPrototypeViewModel()

    var body: some View {
        VStack {
            MainScreenView(optionToChoose: $viewModel.optionToChoose,
                           mainScreenShadowRadius: $viewModel.mainScreenShadowRadius)
            
            OptionButton(text: "This is option A",
                         shadowRadius: $viewModel.optionAShadowRadius,
                         action: {
                             viewModel.selectOptionA()
                         })
            .padding(.trailing, 100)
            
            OptionButton(text: "This is option B",
                         shadowRadius: $viewModel.optionBShadowRadius,
                         action: {
                             viewModel.selectOptionB()
                         })
            .padding(.leading, 100)

            SliderView(
                optionToChoose: $viewModel.optionToChoose,
                mainScreenShadowRadius: $viewModel.mainScreenShadowRadius,
                optionAShadowRadius: $viewModel.optionAShadowRadius,
                optionBShadowRadius: $viewModel.optionBShadowRadius
            )
        }
        .onAppear(perform: prepareHaptics)
    }
}

#Preview {
    DraggerPrototypeView()
}
