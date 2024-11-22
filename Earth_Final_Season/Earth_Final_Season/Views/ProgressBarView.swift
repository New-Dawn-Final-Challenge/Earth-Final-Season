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
    @State var progress: Float = 0
    let total: Float = 600
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ProgressView("", value: progress, total: total)
                .tint(Assets.Colors.accentPrimary.swiftUIColor)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding()
                .frame(width: 350, height: 100)
        }
        .onReceive(timer) { _ in
            if progress < total {
                if let _ = gvm.timer {
                    if !gvm.isPaused  {
                        progress += 1
                    }
                } else {
                    progress += 600
                }
            }
        }
    }
}

#Preview {
    ProgressBarView()
}
