//
//  TestingDesignView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 22/10/24.
//

import SwiftUI
import Design_System

struct TestingDesignView: View {
    var body: some View {
        VStack {
            Assets.Images.characterScreen.swiftUIImage
                .scaleEffect(0.3)

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Assets.Colors.secondaryBlue.swiftUIColor)
        }
        .background(
            Assets.Colors.bgFillPrimary.swiftUIColor
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TestingDesignView()
}
