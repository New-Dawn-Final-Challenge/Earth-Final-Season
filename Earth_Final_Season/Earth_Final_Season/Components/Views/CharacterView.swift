import SwiftUI
import Design_System

struct CharacterView: View {
    let characterImage: String
    let characterName: String
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var triggerChangeChannel: Bool = false

    init(characterImage: String, characterName: String) {
        self.characterImage = characterImage
        self.characterName = characterName
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image rectangle
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .frame(width: getWidth() * CharacterViewConstants.imageFrameWidthMultiplier,
                       height: getHeight() * CharacterViewConstants.imageFrameHeightMultiplier)
                .overlay(
                    VStack {
                        GlitchContentView(trigger: $triggerChangeChannel)
                            .frame(width: getWidth() * CharacterViewConstants.glitchViewWidthMultiplier,
                                   height: getHeight() * CharacterViewConstants.glitchViewHeightMultiplier)
                            .cornerRadius(GlobalConstants.cornerRadius)
                        Spacer()
                        
                        Text(characterName)
                            .font(.bodyFont)
                            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                            .bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: CharacterViewConstants.minTextHeight)
                    }
                    .onChange(of: characterName) {
                        triggerChangeChannel.toggle()
                    }
                    .padding(.vertical, CharacterViewConstants.verticalPadding)
                    .padding(.horizontal)
                )
        }
    }
}

#Preview {
    CharacterView(characterImage: "Placeholder", characterName: "Líder conspiracionista")
}

