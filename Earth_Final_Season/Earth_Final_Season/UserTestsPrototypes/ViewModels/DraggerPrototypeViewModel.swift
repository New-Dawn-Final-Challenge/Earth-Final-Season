//
//  DraggerPrototypeViewModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 27/09/24.
//

import SwiftUI

class DraggerPrototypeViewModel: ObservableObject {
    @Published var currentPosition: CGSize = .zero
    @Published var optionToChoose = "Choose option A"
    @Published var mainScreenShadowRadius = 0
    @Published var optionAShadowRadius = 0
    @Published var optionBShadowRadius = 0
    @Published var circleLocation: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: 170)

    func selectOptionA() {
        optionToChoose = "Choose option A"
    }

    func selectOptionB() {
        optionToChoose = "Choose option B"
    }
}
