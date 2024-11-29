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
        static let lineWidth: CGFloat = 1
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
        static let backgroundPanelHeight: CGFloat = 0.31
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
        static let imageFrameWidthMultiplier: CGFloat = 0.55
        static let imageFrameHeightMultiplier: CGFloat = 0.22
        static let glitchViewWidthMultiplier: CGFloat = 0.54
        static let characterViewCornerRadiusMultiplier: CGFloat = 0.12
        static let glitchViewHeightMultiplier: CGFloat = 0.12
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
        
        static func gameOverAudienceTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "A audiência atingiu seu mínimo" : "Audience reached its minimum"
        }

        static func gameOverEnvironmentTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "A degradação ambiental atingiu seu máximo" : "Environmental Degradation reached its peak"
        }

        static func gameOverIllBeingTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "O mal-estar atingiu seu máximo" : "Ill-being reached its peak"
        }

        static func gameOverInstabilityTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "A instabilidade sociopolítica atingiu seu máximo" : "Sociopolitical instability reached its peak"
        }

        static func gameOverCatTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "Incidente cat-astrófico da bola de pelo" : "Cat-astrophic Yarn Incident"
        }

        static func gameOverRobotVacuumCleanerTitle(isPortuguese: Bool) -> String {
            return isPortuguese ? "O robô aspirador limpou demais" : "Robot Vaccum Cleaner clean too much"
        }

        static func gameOverAudienceMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "Não há uma maneira simples de dizer isso, mas... Você está demitido. Só para deixar claro, sua tarefa era nos entreter destruindo a humanidade, não ajudando. Já tentamos ajudar, mas nunca é tão divertido, acredite. Se precisar de nós no futuro... Bem, não precise" : "There’s no simple way of putting this, but… You’re fired. Just to get it straight, you were supposed to entertain us by wrecking humanity, not by helping them. We already tried helping them, but it’s never as entertaining, trust me. If you ever need us in the future… Well, just don’t"
        }

        static func gameOverEnvironmentMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "A fumaça no céu dá aos raios solares um brilho estranho e roxo. As águas fedem a verde, o clima é ou escaldante ou mortalmente frio, e frutas e colheitas nunca crescem. Toc toc: tem algum humano vivo? A resposta é não" : "Chemtrails in the sky give sunrays a strange purple glow. The waters stink of green, the weather is either burning hot, or deadly cold, and fruits and crops never grow. Toc toc: any human alive? The answer is no"
        }

        static func gameOverIllBeingMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "Feridas são vermelhas, a depressão é azul. Paranoia, ansiedade, dissociação, vírus e bactérias voam livres na Terra numa cruel brisa de verão que colocou os humanoides em um último sono eterno — mas não tão pacífico" : "Wounds are red, depression is blue. Paranoia, anxiety, dissociation, viruses and bacteria flew free on Earth in a cruel summer breeze that put humanoids to one last, eternal — yet not so peaceful — sleep"
        }

        static func gameOverInstabilityMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "Há um ditado antigo sobre a 4ª Guerra Mundial dos humanoides sendo travada com paus e pedras. Mas aqui está a nova piada para essa guerra final: ela nunca será travada, porque não há um único humano para lutar" : "There’s an ancient saying regarding humanoid World War IV being fought with sticks and stones. But here’s a new punch line for this final war: it will never be fought, because there’s not a single human left to fight it"
        }

        static func gameOverCatMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "Sério? Uma bola de pelo? Qual é, você é fofo, era nossa melhor aposta para causar o maior caos nos humanoides, mas você arruinou tudo! Você brincou com a bola da destruição, e agora, a humanidade está destruída, e não há ninguém para aplaudir seu trabalho" : "Seriously? A ball of yarn? Come on, you look cute, you were our best bet to cause the most chaos to the humanoids, but you ruined it all! You played with the ball of destruction, and now, humanity is destroyed, and there is no one to applaud your work."
        }

        static func gameOverRobotVacuumCleanerMessage(isPortuguese: Bool) -> String {
            return isPortuguese ? "Comida? Cadeiras? Pés? TUDO?! Você limpou tanto que não há sujeira, nem uma migalha para uma barata comer — só um deserto imaculado e com cheiro de limão. Como as doenças devem se espalhar agora? Parabéns, robô idiota, você aspirou a existência... e a audiência. Ótimo trabalho!" : "Food? Chairs? Feet? EVERYTHING?! You cleaned so much there’s no dirt, not even a crumb for a cockroach to snack on—just a spotless, lemon-scented wasteland. How are diseases supposed to spread now? Congrats, idiot robot, you vacuumed away existence... and the audience. Great job!"
        }
    }

    struct Haptics {
        static let defaultIntensity: Float = 1.0
        static let defaultSharpness: Float = 0.3
        static let strideInterval: Double = 0.01
        static let relativeTimeLimit: Double = 0.5
    }

    struct GameOverView {
        static let vstackSpacing: CGFloat = 12
        static let vstackComponentsSpacing: CGFloat = 6
        static let glitchTextIntensity: CGFloat = 2
        static let starViewOpacity: CGFloat = 0.6
        static let starViewRadius: CGFloat = 2
        static let starViewX: CGFloat = -2
        static let starViewY: CGFloat = 2
        static let gameOverMonitorImageWidth: CGFloat = 0.7
        static let gameOverMonitorImageHeight: CGFloat = 0.15
        static let gameOverImageRadius: CGFloat = 40
        static let gameOverImagePaddingHorizontal: CGFloat = 40
        static let gameOverImagePaddingVertical: CGFloat = 18
        static let titleShadowRadius: CGFloat = 0.3
        static let descriptionPadding: CGFloat = 35
        static let descriptionWidth: CGFloat = 0.8
        static let descriptionHeight: CGFloat = 0.4
    }
    
    struct CharacterGalleryView {
        static let gridColumns: Int = 2
        static let gridSpacing: CGFloat = 0
        static let vstackSpacing: CGFloat = 16
        static let vstackPadding: CGFloat = 16
        static let closeButtonPadding: CGFloat = -24
        static let characterComponentWidth: CGFloat = 0.4
        static let characterComponentHeight: CGFloat = 0.27
        static let characterInfoSpacing: CGFloat = 8
        static let characterInfoPadding: CGFloat = 12
        static let characterMonitorWidth: CGFloat = 0.35
        static let characterMonitorHeight: CGFloat = 0.12
        static let shadowRadius: CGFloat = 0
        static let shadowX: CGFloat = -1.5
        static let shadowY: CGFloat = 0.5
    }
    
    struct AboutUsView {
        static let vstackSpacing: CGFloat = 24
        static let membersGridSpacing: CGFloat = 40
        static let descriptionTextPadding: CGFloat = 30
        static let gameImageWidth: CGFloat = 0.25
        static let gameImageHeight: CGFloat = 0.12
        static let gameImagePadding: CGFloat = -8
        static let membersGridPadding: CGFloat = -12
    }

    struct GameplayView {
        static let helperButtonsPaddingTrailing: CGFloat = 60
        static let helperButtonsPaddingTop: CGFloat = 30
        static let indicatorSpacingMultiplier: CGFloat = -0.02
        static let panelAccessoryWidthMultiplier: CGFloat = 0.25
        static let panelAccessoryHeightMultiplier: CGFloat = 0.06
        static let staticPanelWidth: CGFloat = 0.8
        static let staticPanelHeight: CGFloat = 0.07
        static let paddingTopChoiceView: CGFloat = -15
        static let panelPaddingTop: CGFloat = 30
        static let staticPanelPaddingTop: CGFloat = 42
        static let panelHorizontalPadding: CGFloat = 30
        static let staticPanelHorizontalPadding: CGFloat = 0
    }

    struct MenuView {
        static let userDefaultsFirstTimePlayingKey: String = "firstTimePlaying"
        static let titleWidthMultiplier: CGFloat = 0.5
        static let titleHeightMultiplier: CGFloat = 0.06
        static let buttonWidthMultiplier: CGFloat = 0.5
        static let buttonHeightMultiplier: CGFloat = 0.06
        static let buttonCornerRadius: CGFloat = 10
        static let verticalSpacing: CGFloat = 12
        static let backgroundHeightDivider: CGFloat = 2.7
        static let globeHeightDivider: CGFloat = 2.9
        static let gamePaddingTop: CGFloat = 18
        static let gamePaddingBottom: CGFloat = 7
    }

    struct SettingsView {
        static let sliderRange: ClosedRange<Float> = 0...100
        static let padding: CGFloat = 32
        static let transitionDuration: Double = 0.5
    }
  
    struct AnimatedTVEffect {
        static let frameUpdateInterval: CGFloat = 0.016
        static let defaultEffectDuration: CGFloat = 1.0
        static let defaultEffectInterval: CGFloat = 10.0
        static let noiseOpacity: Double = 0.55
    }

    struct GameplayViewModel {
        static let countdownStartValue = 6
        static let indicatorInitialScale: CGFloat = 0
        static let indicatorVisibleScale: CGFloat = 1
        static let shadowRadiusHighlight = 7
        static let timerInterval: TimeInterval = 1
    }

    struct GlitchContentView {
        static let glitchInterval: TimeInterval = 3.0
        static let keyframeDuration: TimeInterval = 0.1
        static let initialShadowOpacity: Double = 0.2
        static let firstShadowOpacity: Double = 0.6
        static let secondShadowOpacity: Double = 0.8
        static let thirdShadowOpacity: Double = 0.4
        static let finalShadowOpacity: Double = 0.1
        static let offsetTop: CGFloat = 5
        static let offsetCenter: CGFloat = 0
        static let offsetBottom: CGFloat = 5
    }

    struct GlitchImageView {
        static let offsetRange: ClosedRange<CGFloat> = -20...20
        static let intensityRange: ClosedRange<CGFloat> = -2...2
        static let animationDuration: Double = 0.1
        static let xOffsetMultiplier: CGFloat = 0.5
        static let yOffsetMultiplier: CGFloat = 0.3
    }
    
    struct Settings {
        static let defaultMusicIntensity: Float = 100.0
        static let defaultEffectsIntensity: Float = 100.0
        static let defaultHapticsIntensity: Float = 100.0
        static let soundEffectsDefaultIntensity: Float = 100.0
        static let maxIntensity: Float = 100.0
        static let userDefaultsEffectsKey = "effectsIntensity"
        static let userDefaultsMusicKey = "musicIntensity"
        static let userDefaultsHapticsKey = "hapticsIntensity"
        static let userDefaultsHapticsEnabledKey = "hapticsEnabled"
        static let userDefaultsGestureKey = "selectedGesture"
    }

}
