//
//  SliderBarView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 06/11/24.
//

import SwiftUI
import Design_System

struct SliderBarView: View {
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    var body: some View {
        Assets.Images.sliderBar.swiftUIImage
            .resizable()
            .frame(width: sliderWidth, height: sliderHeight)
    }
}
