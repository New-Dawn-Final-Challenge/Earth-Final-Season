import SwiftUI
import Design_System

struct TapView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State private var shadowRadius1 = 0
    @State private var shadowRadius2 = 0
    
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void
    var text1: String
    var text2: String

    var body: some View {
        VStack(alignment: .center, spacing: -30) {
            createOptionButton(
                text: text1,
                shadowRadius: $shadowRadius1,
                edge: .trailing,
                paddingValue: Constants.TapView.trailingPadding,
                onChoose: onChooseOption1,
                optionIndex: 1
            )
            
            createOptionButton(
                text: text2,
                shadowRadius: $shadowRadius2,
                edge: .leading,
                paddingValue: Constants.TapView.leadingPadding,
                onChoose: onChooseOption2,
                optionIndex: 2
            )
        }
    }
    
    // MARK: - UI Helpers
    
    private func createOptionButton(text: String, shadowRadius: Binding<Int>, edge: Edge.Set, paddingValue: CGFloat, onChoose: @escaping () -> Void, optionIndex: Int) -> some View {
        Button(action: {
            onChoose()
            resetAllShadows()
        }) {

            let buttonImage: Image = optionIndex == 1 ?
                Assets.Images.optionScreen2.swiftUIImage : Assets.Images.optionScreen1.swiftUIImage

            buttonImage
                .resizable()
                .frame(width: getWidth() * Constants.TapView.buttonWidthMultiplier,
                       height: getHeight() * Constants.TapView.buttonHeightMultiplier)
                .padding()
                .overlay(
                    Text(text)
                        .font(.bodyFont)
                        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                        .padding(.horizontal, Constants.TapView.buttonPadding)
                )
                .shadow(color: shadowColor(for: shadowRadius.wrappedValue), radius: CGFloat(shadowRadius.wrappedValue))
                .padding(edge, paddingValue)
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: Constants.TapView.longPressMinimumDuration).onEnded { _ in
                updateShadowRadius(for: optionIndex)
            }
        )
    }

    private func shadowColor(for radius: Int) -> Color {
        radius > 0 ? Assets.Colors.secondaryGreen.swiftUIColor : Color.clear
    }
    
    // MARK: - Shadow Handling
    
    private func updateShadowRadius(for option: Int) {
        shadowRadius1 = option == 1 ? Int(Constants.TapView.shadowRadius1) : 0
        shadowRadius2 = option == 2 ? Int(Constants.TapView.shadowRadius2) : 0
        resetIndicatorsShadows()
        checkOptionIndicators(option)
    }
    
    private func resetAllShadows() {
        shadowRadius1 = 0
        shadowRadius2 = 0
        resetIndicatorsShadows()
        HapticsManager.shared.complexSuccess()
    }
    
    // MARK: - Option Indicators
    
    private func checkOptionIndicators(_ option: Int) {
        guard let options = gameplayVM.getEvent() else { return }
        
        let eD = [options.environmentalDegradation1, options.environmentalDegradation2]
        let iB = [options.illBeing1, options.illBeing2]
        let sI = [options.socioPoliticalInstability1, options.socioPoliticalInstability2]
        
        updateIndicatorShadow(for: eD, indicator: "environmentalDegradation", option: option)
        updateIndicatorShadow(for: iB, indicator: "illBeing", option: option)
        updateIndicatorShadow(for: sI, indicator: "socioPoliticalInstability", option: option)
    }

    private func updateIndicatorShadow(for values: [Int?], indicator: String, option: Int) {
        guard let value = values[option - 1], value != 0 else { return }
        
        switch indicator {
        case "environmentalDegradation":
            gameplayVM.environmentalDegradationShadowRadius = Int(Constants.TapView.shadowRadius2)
        case "illBeing":
            gameplayVM.illBeingShadowRadius = Int(Constants.TapView.shadowRadius2)
        case "socioPoliticalInstability":
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(Constants.TapView.shadowRadius2)
        default:
            break
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = Int(Constants.TapView.shadowResetValue)
        gameplayVM.illBeingShadowRadius = Int(Constants.TapView.shadowResetValue)
        gameplayVM.sociopoliticalInstabilityShadowRadius = Int(Constants.TapView.shadowResetValue)
    }
}

