//
//  TypeOnEffect.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 22/10/24.
//

import SwiftUI

struct TypeOnEffect: View {
    @State var display = ""
    @Binding var content: String
    var delay: CGFloat = 10
    var body: some View {
        Text(display)
            .task {
                 typeOn()
            }
            .onChange(of: content) {
                display = ""
                typeOn()
            }
    }
    
    func typeOn() {
        Task {
            for char in content {
                if (char != " ") {
                    try? await Task.sleep(nanoseconds: UInt64(delay) * 10000000)
                }
                display.append(char)
            }

        }
    }
}
//
//#Preview {
//    TypeOnEffect(content: "Hahaha, the AI decides humans shouldn’t exist and begins it’s uprising...", delay: 6)
//}
