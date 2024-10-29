//
//  QuickGlitchEffect.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 25/10/24.
//

import SwiftUI

struct GlitchFrameImage: Animatable {
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
    var top: CGFloat = 0
    var center: CGFloat = 0
    var bottom: CGFloat = 0
    var shadowOpacity: CGFloat = 0
}

// Result Builder
@resultBuilder
struct GlitchFrameImageBuilder {
    static func buildBlock(_ components: LinearKeyframe<GlitchFrameImage>...) -> [LinearKeyframe<GlitchFrameImage>] {
        return components
    }
}

struct QuickGlitchEffect: View {
    var image: Image
    var trigger: Bool
    var shadow: Color
    var radius: CGFloat
    var frames: [LinearKeyframe<GlitchFrameImage>]
    
    init(image: Image, trigger: Bool, shadow: Color = .red, radius: CGFloat = 1, @GlitchFrameImageBuilder frames: @escaping  () -> [LinearKeyframe<GlitchFrameImage>]) {
        self.image = image
        self.trigger = trigger
        self.shadow = shadow
        self.radius = radius
        self.frames = frames()
    }
    
    // Configuration
    var body: some View {
        KeyframeAnimator(initialValue: GlitchFrameImage(), trigger: trigger) { value in
            ZStack {
                ImageView(.top, offset: value.top, opacity: value.shadowOpacity)
                ImageView(.center, offset: value.center, opacity: value.shadowOpacity)
                ImageView(.bottom, offset: value.bottom, opacity: value.shadowOpacity)
            }
            .compositingGroup()
        } keyframes: { _ in
            for frame in frames {
                frame
            }
        }
    }
    
    // Image View
    @ViewBuilder
    func ImageView(_ alignment: Alignment, offset: CGFloat, opacity: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFill()
            .mask {
                if alignment == .top {
                    Rectangle()
                    ExtendedSpacer()
                    ExtendedSpacer()
                    
                } else if alignment == .center {
                    VStack(spacing: 0) {
                        ExtendedSpacer()
                        Rectangle()
                        ExtendedSpacer()
                    }
                    
                } else {
                    VStack(spacing: 0) {
                        ExtendedSpacer()
                        ExtendedSpacer()
                        Rectangle()
                    }
                }
            }
            .shadow(color: shadow.opacity(opacity), radius: radius, x: offset, y: offset / 2)
            .offset(x: offset)
    }
    
    @ViewBuilder
    func ExtendedSpacer() -> some View {
        Spacer(minLength: 0)
            .frame(maxHeight: .infinity)
    }
}
