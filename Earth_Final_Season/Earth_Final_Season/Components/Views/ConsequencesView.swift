import SwiftUI
import Design_System

struct ConsequencesView: View {
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
            .frame(width: getWidth() * ConsequencesViewConstants.frameWidthMultiplier,
                   height: getHeight() * ConsequencesViewConstants.frameHeightMultiplier)
            .foregroundStyle(Color(UIColor.systemGray4))
            .padding()
            .overlay(
                Text(text)
                    .font(.bodyFont)
                    .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            )
    }
}

#Preview {
    ConsequencesView(text: "")
}

