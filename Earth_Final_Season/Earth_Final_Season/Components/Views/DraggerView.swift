//
//  DraggerView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 06/11/24.
//

import SwiftUI
import Design_System

struct DraggerView: View {
    @Binding var dragOffset: CGSize
    @Binding var feedbackTrigger: CGPoint
    
    var body: some View {
        Assets.Images.sliderDragger.swiftUIImage
            .resizable()
            .scaledToFit()
            .padding(-30)
            .offset(dragOffset)
    }
}
