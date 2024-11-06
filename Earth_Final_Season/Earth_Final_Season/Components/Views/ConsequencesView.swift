import SwiftUI
import Design_System

struct ConsequencesView: View {
    var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .frame(width: getWidth() * Constants.ConsequencesView.frameWidthMultiplier,
                   height: getHeight() * Constants.ConsequencesView.frameHeightMultiplier)
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

