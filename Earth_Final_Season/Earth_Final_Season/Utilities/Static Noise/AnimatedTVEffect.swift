import SwiftUI

struct AnimatedTVEffect: View {
    @State private var elapsed: CGFloat = 0.0
    @State private var showEffect: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                GlitchImageView()
                    .scaledToFit()
                    .distortionEffect(
                        ShaderLibrary.wave(.float(elapsed)),
                        maxSampleOffset: .zero
                    )
                
                Text("Static Noise Effect")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            
            MetalStaticNoiseView()
                .edgesIgnoringSafeArea(.all)
                .opacity(Constants.AnimatedTVEffect.noiseOpacity)
                .zIndex(3)
        }
        .ignoresSafeArea()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: Constants.AnimatedTVEffect.frameUpdateInterval, repeats: true) { timer in
                elapsed += Constants.AnimatedTVEffect.frameUpdateInterval
                
                if Int(elapsed) % Int(Constants.AnimatedTVEffect.defaultEffectInterval) == 0 {
                    showEffect = true
                }
                
                if showEffect && elapsed.truncatingRemainder(dividingBy: Constants.AnimatedTVEffect.defaultEffectInterval) > Constants.AnimatedTVEffect.defaultEffectDuration {
                    showEffect = false
                }
            }
        }
    }
}

#Preview {
    AnimatedTVEffect()
}

