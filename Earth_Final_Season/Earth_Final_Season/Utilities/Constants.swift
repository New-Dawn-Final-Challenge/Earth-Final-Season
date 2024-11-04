//
//  Constants.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 04/11/24.
//

import CoreFoundation
import CoreGraphics
import SwiftUI

struct GlobalConstants{
    static let cornerRadius: CGFloat = 16
}

struct AudienceIndicatorConstants {
    static let imageWidthMultiplier: CGFloat = 0.084
    static let imageHeightMultiplier: CGFloat = 0.042
    static let barWidthMultiplier: CGFloat = 0.094
    static let barHeightMultiplier: CGFloat = 0.087
    static let percentageOffset: CGFloat = 3
    static let percentageScaleFactor: CGFloat = 8
}

struct BackgroundViewConstants {
    static let colorRed: Double = 0.208
    static let colorGreen: Double = 0.212
    static let colorBlue: Double = 0.216
    static let opacity: Double = 0.7
    
    // Animation constants
    static let animationDuration: Double = 20.0
    static let animationRepeatDuration: Double = 60.0
    static let scaleEffectValue: CGFloat = 1.5
    static let firstRotationAngle: Double = -90
    static let secondRotationAngle: Double = 60
    
    // Frame and alignment
    static let frameWidth1: CGFloat = 100
    static let frameHeight1: CGFloat = 0 // Assuming this is intentional, otherwise adjust as needed
    static let frameWidth2: CGFloat = 700
    static let frameHeight2: CGFloat = 1000
    
    // Corner radius for emitters
    static let emitterCornerRadius: CGFloat = 12
}

struct ChaosIndicatorsValueChangeConstants {
    static let arrowWidthMultiplier: CGFloat = 0.03
    static let arrowHeightMultiplier: CGFloat = 0.015
    static let hStackSpacing: CGFloat = 4
    static let animationDuration: Double = 1.0
}

struct ChaosIndicatorsConstants {
    static let indicatorFrameWidthMultiplier: CGFloat = 0.6
    static let indicatorFrameHeightMultiplier: CGFloat = 0.145
    static let frameWidthMultiplier: CGFloat = 0.14
    static let frameHeightMultiplier: CGFloat = 0.05
    static let changeViewWidthMultiplier: CGFloat = 0.1
    static let changeViewHeightMultiplier: CGFloat = 0.01
    static let hStackSpacing: CGFloat = 12
    static let animationDuration: Double = 1.0
    static let animationRepeatCount: Int = 3
}

struct CharacterViewConstants {
    static let imageFrameWidthMultiplier: CGFloat = 0.5
    static let imageFrameHeightMultiplier: CGFloat = 0.18
    static let glitchViewWidthMultiplier: CGFloat = 0.28
    static let glitchViewHeightMultiplier: CGFloat = 0.10
    static let verticalPadding: CGFloat = 30
    static let minTextHeight: CGFloat = 20
}

struct ChoicesViewConstants {
    static let imageFrameWidthMultiplier: CGFloat = 0.8
    static let imageFrameHeightMultiplier: CGFloat = 0.12
    static let horizontalPadding: CGFloat = 50
}

struct ConsequencesViewConstants {
    static let frameWidthMultiplier: CGFloat = 0.8
    static let frameHeightMultiplier: CGFloat = 0.08
}

struct EventViewConstants {
    static let frameWidthMultiplier: CGFloat = 0.8
    static let frameHeightMultiplier: CGFloat = 0.15
    static let horizontalPadding: CGFloat = 40
}

struct ButtonViewConstants {
    static let frameWidthMultiplier: CGFloat = 0.1
    static let frameHeightMultiplier: CGFloat = 0.05
}

struct SliderViewConstants {
    static let widthMultiplier: CGFloat = 0.4
    static let heightMultiplier: CGFloat = 0.03
    static let draggerPadding: CGFloat = -30
    static let sliderLimitFactor: CGFloat = 2.5
    static let hapticFeedback: CGFloat = 0.28
}

struct TapViewConstants {
    static let buttonWidthMultiplier: CGFloat = 0.8
    static let buttonHeightMultiplier: CGFloat = 0.12
    static let buttonPadding: CGFloat = 50
    static let longPressMinimumDuration: Double = 0.1
    static let shadowRadius1: CGFloat = 18
    static let shadowRadius2: CGFloat = 14
    static let shadowResetValue: CGFloat = 0
    static let trailingPadding: CGFloat = 130
    static let leadingPadding: CGFloat = 130
}




