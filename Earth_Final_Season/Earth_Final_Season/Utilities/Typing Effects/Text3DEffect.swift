//
//  Text3dEffect.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 04/11/24.
//

import SwiftUI

struct Text3dEffect: View {
    var text: String = "Settings"
    var body: some View {
        ZStack {
            Text(text)
                .foregroundStyle(.green)
                .shadow(color: .green, radius: 32)
                .offset(x: 2, y: 1)
                .opacity(0.8)
            Text(text)
                .foregroundStyle(.red)
                .offset(x: -2, y: -1)
                .shadow(color: .red, radius: 32)
                .opacity(0.8)
            Text(text)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    Text3dEffect(text: "Example")
}
