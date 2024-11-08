//
//  GlitchView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 22/10/24.
//

import SwiftUI

struct GlitchFrame: Animatable {
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>> {
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
    
    var top: CGFloat = 0
    var center: CGFloat = 0
    var bottom: CGFloat = 0
    var shadowOpacity: CGFloat = 0
}

@resultBuilder
struct GlitchFrameBuilder {
    static func buildBlock(_ components: LinearKeyframe<GlitchFrame>...) -> [LinearKeyframe<GlitchFrame>] {
        return components
    }
}

struct GlitchView: View {
    var text: String
    var trigger: Bool
    var shadow: Color
    var radius: CGFloat = 1
    var frames: [LinearKeyframe<GlitchFrame>]
    
    init(text: String = "Hahaha, the AI decides humans shouldn’t exist and begins it’s uprising…", trigger: Bool = false, shadow: SwiftUICore.Color = Color.red, radius: CGFloat, @GlitchFrameBuilder frames: @escaping () ->  [LinearKeyframe<GlitchFrame>]) {
        self.text = text
        self.trigger = trigger
        self.shadow = shadow
        self.radius = radius
        self.frames = frames()
    }
    
    var body: some View {
        KeyframeAnimator(initialValue: GlitchFrame(), trigger: trigger) { value in
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
                        offset/2)
            .offset(x: offset)
    }
}
