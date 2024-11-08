//
//  GlitchCharacterEffect.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 05/11/24.
//

import SwiftUI

struct CharacterGlitch: Animatable {
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat >>> {
        get {
            return .init(top, .init(center, .init(bottom, shadowOpacity)))
        }
        
        set {
            top = newValue.first
            center = newValue.second.first
            bottom = newValue.second.second.first
            shadowOpacity = newValue.second.second.second
        }
    }
    
    // X-Offset's
    // swiftlint:disable:next minlength
    var top: CGFloat = 0
    var center: CGFloat = 0
    var bottom: CGFloat = 0
    var shadowOpacity: CGFloat = 0
}

// Result Builder
@resultBuilder
struct GlitchCharacterBuilder {
    static func buildBlock(_ components: LinearKeyframe<CharacterGlitch>...) -> [LinearKeyframe<CharacterGlitch>] {
        return components
    }
}

struct GlitchCharacterEffect: View {
    var text: String
    var trigger: Bool
    var shadow: Color
    var radius: CGFloat
    var frames: [LinearKeyframe<CharacterGlitch>]
    
    init(text: String, trigger: Bool, shadow: Color = .red, radius: CGFloat = 1, @GlitchCharacterBuilder frames: @escaping  () -> [LinearKeyframe<CharacterGlitch>]) {
        self.text = text
        self.trigger = trigger
        self.shadow = shadow
        self.radius = radius
        self.frames = frames()
    }
    
    // Configuration
    var body: some View {
        KeyframeAnimator(initialValue: CharacterGlitch(), trigger: trigger) { value in
            ZStack {
                textView(.top, offset: value.top, opacity: value.shadowOpacity)
                textView(.center, offset: value.center, opacity: value.shadowOpacity)
                textView(.bottom, offset: value.bottom, opacity: value.shadowOpacity)
            }
            .compositingGroup()
        } keyframes: { _ in
            for frame in frames {
                frame
            }
        }
    }
    
    // Text View
    @ViewBuilder
    func textView(_ alignment: Alignment, offset: CGFloat, opacity: CGFloat) -> some View {
        Text(text)
            .mask {
                switch(alignment) {
                case .top:
                    Rectangle()
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                case .center:
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                    Rectangle()
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                default:
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                    Spacer(minLength: 0)
                        .frame(maxHeight: .infinity)
                    Rectangle()
                }
        }
            .shadow(color: shadow.opacity(opacity), radius: radius, x: offset, y:
                        offset / 2)
            .offset(x: offset)
    }
    
    @ViewBuilder
    func ExtendedSpacer() -> some View {
        Spacer(minLength: 0)
            .frame(maxHeight: .infinity)
    }
}
