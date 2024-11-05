//
//  Emitter.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 23/10/24.
//

import UIKit
import SwiftUI


struct Emitters {
    static let starField = ParticlesEmitter {
        EmitterCell()
            .content(.circle(16.0))
            .color(UIColor.white.withAlphaComponent(0.0))
            .lifetime(10)
            .birthRate(40)
            .scale(0.01)
            .scaleRange(0.004)
            .scaleSpeed(0.005)
            .alphaSpeed(0.01) // Velocity of the Emitters
            .velocity(100)
            .emissionRange(-.pi)
    }
}

struct EmitterConfig: Identifiable {
    let emitter: ParticlesEmitter
    let size: CGSize
    let shape: CAEmitterLayerEmitterShape
    let position: CGPoint
    let name: String
    let background: String
    
    // To make the ForEach work
    let id = UUID()
}
