//
//  PrototypeSelectionView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 26/09/24.
//

import SwiftUI

struct PrototypeSelectionView: View {
    var body: some View {
        VStack(spacing: 12) {
            NavigationLink(
                destination:
                    DraggerPrototypeView()
                        .navigationBarHidden(true),
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("Dragger Prototype")
                                .foregroundStyle(Color.white)
                        )
                }
            )
            
            NavigationLink(
                destination:
                    ButtonsPrototypeView()
                        .navigationBarHidden(true),
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("Buttons Prototype")
                                .foregroundStyle(Color.white)
                        )
                }
            )
        }
    }
}

#Preview {
    PrototypeSelectionView()
}
