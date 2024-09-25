//
//  SliderView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 25/09/24.
//

import SwiftUI

struct SliderView: View {
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 20)
                .cornerRadius(10)
        }
    }
}

#Preview {
    SliderView()
}
