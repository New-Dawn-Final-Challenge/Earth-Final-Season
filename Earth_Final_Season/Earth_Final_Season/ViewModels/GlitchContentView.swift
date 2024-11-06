import SwiftUI

struct GlitchContentView: View {
    @Binding var trigger: Bool
    @State private var glitchTimer: Timer? = nil
    let uiImage = Image("image1")
    
    var body: some View {
        VStack {
            ZStack {
                QuickGlitchEffect(image: uiImage, trigger: trigger) {
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetCenter, bottom: Constants.GlitchContentView.offsetCenter, shadowOpacity: Constants.GlitchContentView.initialShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: -Constants.GlitchContentView.offsetTop, bottom: -Constants.GlitchContentView.offsetTop, shadowOpacity: Constants.GlitchContentView.firstShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: -Constants.GlitchContentView.offsetTop, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.secondShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetTop, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.thirdShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetCenter, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.finalShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(), duration: Constants.GlitchContentView.keyframeDuration)
                }
                .hidden()
                
                QuickGlitchEffect(image: uiImage, trigger: trigger, shadow: .green) {
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetCenter, bottom: Constants.GlitchContentView.offsetCenter, shadowOpacity: Constants.GlitchContentView.initialShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: -Constants.GlitchContentView.offsetTop, bottom: -Constants.GlitchContentView.offsetTop, shadowOpacity: Constants.GlitchContentView.firstShadowOpacity * 0.5),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: -Constants.GlitchContentView.offsetTop, center: -Constants.GlitchContentView.offsetTop, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.secondShadowOpacity * 0.625),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetTop, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.thirdShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(top: Constants.GlitchContentView.offsetTop, center: Constants.GlitchContentView.offsetCenter, bottom: Constants.GlitchContentView.offsetBottom, shadowOpacity: Constants.GlitchContentView.finalShadowOpacity),
                                   duration: Constants.GlitchContentView.keyframeDuration)
                    
                    LinearKeyframe(GlitchFrameImage(), duration: Constants.GlitchContentView.keyframeDuration)
                }
            }
        }
        .padding()
        .onAppear {
            startGlitchTimer()
        }
    }
    
    func startGlitchTimer() {
        trigger.toggle()
    }
}

