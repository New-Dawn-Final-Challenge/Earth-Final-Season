//
//  ButtonsPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import SwiftUI

struct ButtonsPrototypeView: View {
    
    @State private var optionToChoose = "Choose option A"
    @State private var counter = 0

    var body: some View {
        VStack {
            Spacer()

            Text(optionToChoose)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                )

            Spacer()

            Button(
                action: {
                    withAnimation {
                        if counter > 5 {
                            optionToChoose = "Great! That's enough"
                        } else {
                            optionToChoose = "Choose option B"
                        }
                        
                        counter += 1
                    }
                },
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("This is option A")
                                .foregroundStyle(Color.white)
                        )
                }
            )
            .padding(.bottom, -16)

            Button(
                action: {
                    withAnimation {
                        if counter > 5 {
                            optionToChoose = "Great! That's enough"
                        } else {
                            optionToChoose = "Choose option A"
                        }
                        
                        counter += 1
                    }
                },
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("This is option B")
                                .foregroundStyle(Color.white)
                        )
                }
            )
        }
    }
}

#Preview {
    ButtonsPrototypeView()
}
