//
//  Constants.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 04/11/24.
//

import CoreFoundation
import CoreGraphics
import SwiftUI

struct Constants{
    
    struct Global{
        static let cornerRadius: CGFloat = 16
    }

    struct AudienceIndicator {
        static let imageWidthMultiplier: CGFloat = 0.05
        static let imageHeightMultiplier: CGFloat = 0.025
        static let barWidthMultiplier: CGFloat = 0.04
        static let barHeightMultiplier: CGFloat = 0.05
        static let percentageOffset: CGFloat = 3
        static let percentageScaleFactor: CGFloat = 8
    }

    struct BackgroundView {
        static let colorRed: Double = 0.208
        static let colorGreen: Double = 0.212
        static let colorBlue: Double = 0.216
        static let opacity: Double = 0.7
        
        // Animation 
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

    struct ChaosIndicatorsValueChange {
        static let arrowWidthMultiplier: CGFloat = 0.02
        static let arrowHeightMultiplier: CGFloat = 0.01
        static let hStackSpacing: CGFloat = 2
        static let animationDuration: Double = 1.0
    }

    struct ChaosIndicators {
        static let indicatorFrameWidthMultiplier: CGFloat = 0.45
        static let indicatorFrameHeightMultiplier: CGFloat = 0.1
        static let frameWidthMultiplier: CGFloat = 0.1
        static let frameHeightMultiplier: CGFloat = 0.043
        static let indicatorMonitorHeightMultiplier: CGFloat = 0.1
        static let changeViewWidthMultiplier: CGFloat = 0.1
        static let changeViewHeightMultiplier: CGFloat = 0.01
        static let hStackSpacing: CGFloat = 12
        static let animationDuration: Double = 1.0
        static let animationRepeatCount: Int = 3
    }
    
    struct BlackPanel {
        static let horizontalSpacing: CGFloat = 6
        static let panelHeight: CGFloat = 0.125
        static let backgroundPanelHeight: CGFloat = 0.38
        static let yearMonitorHeight: CGFloat = 0.1
        static let sidePanelWidth: CGFloat = 0.1
        static let yearPanelWidth: CGFloat = 0.3
        static let indicatorPanelWidth: CGFloat = 0.6
        static let bottomPanelWidth: CGFloat = 1.05
        static let yearMonitorWidth: CGFloat = 0.2
        static let sidePanelPadding: CGFloat = -20
        static let bottomPadding: CGFloat = 80
        static let yearMonitorPadding: CGFloat = 8
    }

    struct CharacterView {
        static let imageFrameWidthMultiplier: CGFloat = 0.5
        static let imageFrameHeightMultiplier: CGFloat = 0.18
        static let glitchViewWidthMultiplier: CGFloat = 0.28
        static let glitchViewHeightMultiplier: CGFloat = 0.10
        static let verticalPadding: CGFloat = 30
        static let minTextHeight: CGFloat = 20
    }

    struct ChoicesView {
        static let imageFrameWidthMultiplier: CGFloat = 0.8
        static let imageFrameHeightMultiplier: CGFloat = 0.12
        static let horizontalPadding: CGFloat = 50
    }

    struct ConsequencesView {
        static let frameWidthMultiplier: CGFloat = 0.8
        static let frameHeightMultiplier: CGFloat = 0.08
    }

    struct EventView {
        static let frameWidthMultiplier: CGFloat = 0.8
        static let frameHeightMultiplier: CGFloat = 0.15
        static let horizontalPadding: CGFloat = 40
    }

    struct ButtonView {
        static let frameWidthMultiplier: CGFloat = 0.1
        static let frameHeightMultiplier: CGFloat = 0.05
    }

    struct SliderView {
        static let widthMultiplier: CGFloat = 0.4
        static let heightMultiplier: CGFloat = 0.03
        static let draggerPadding: CGFloat = -30
        static let sliderLimitFactor: CGFloat = 2.5
        static let hapticFeedback: CGFloat = 0.28
    }

    struct TapView {
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

    struct GameEngine {
        static let initialAudience: Double = 5
        static let initialIllBeing = 6
        static let initialSocioPoliticalInstability = 6
        static let initialEnvironmentalDegradation = 6
        static let initialYear = 0

        static let minAudienceThreshold: Double = 3
        static let maxIndicatorThreshold = 12
        static let eventsPerYear = 2

        static let gameOverAudienceMessage = "The reality has reached zero audience."
        static let gameOverEnvironmentMessage = "The earth is barren, and nature has collapsed. The damage is irreversible."
        static let gameOverIllBeingMessage = "The people are overwhelmed by suffering and despair. Society can no longer endure."
        static let gameOverInstabilityMessage = "Chaos and conflict have torn society apart. Order is lost, and survival is impossible."
    }

    struct Haptics {
        static let defaultIntensity: Float = 1.0
        static let defaultSharpness: Float = 0.3
        static let strideInterval: Double = 0.01
        static let relativeTimeLimit: Double = 0.5
    }

    struct GameOverView {
        static let glitchTextIntensity: CGFloat = 2
        static let hackerTextSpeed: Double = 0.001
        static let hackerTextLineLimit: Int = 4
        static let buttonAnimationDuration: Double = 4.5
        static let buttonOpacityDelay: UInt64 = 45000  // nanoseconds for task sleep
    }

    struct GameplayView {
        static let helperButtonsPaddingTrailing: CGFloat = 50
        static let helperButtonsPaddingTop: CGFloat = 32
        static let indicatorSpacingMultiplier: CGFloat = -0.02
        static let panelAccessoryWidthMultiplier: CGFloat = 0.3
        static let panelAccessoryHeightMultiplier: CGFloat = 0.08
        static let staticPanelWidth: CGFloat = 1.05
        static let staticPanelHeight: CGFloat = 0.08
        static let paddingTopChoiceView: CGFloat = -15
        static let panelPaddingTop: CGFloat = 30
        static let panelHorizontalPadding: CGFloat = 30
    }

    struct MenuView {
        static let titleWidthMultiplier: CGFloat = 0.5
        static let titleHeightMultiplier: CGFloat = 0.06
        static let buttonWidthMultiplier: CGFloat = 0.5
        static let buttonHeightMultiplier: CGFloat = 0.06
        static let buttonCornerRadius: CGFloat = 10
        static let verticalSpacing: CGFloat = 20
    }

    struct SettingsView {
        static let sliderRange: ClosedRange<Float> = 0...100
        static let padding: CGFloat = 32
        static let transitionDuration: Double = 0.5
    }
}
