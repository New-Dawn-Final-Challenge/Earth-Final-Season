//
//  SliderProgressView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 21/11/24.
//

import SwiftUI
import Design_System

struct ProgressBarView: View {
    @Environment(GameplayViewModel.self) private var gvm
    
    var body: some View {
        ZStack {
            ProgressView("", value: gvm.progress, total: 1.0)
                .tint(Assets.Colors.accentPrimary.swiftUIColor)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding()
                .frame(width: 350, height: 100)
        }
        
    }
}

#Preview {
    ProgressBarView()
}
