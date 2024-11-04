import SwiftUI
import Design_System

struct TapView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State var shadowRadius1 = 0
    @State var shadowRadius2 = 0
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void
    var text1: String
    var text2: String

    var body: some View {
        VStack(alignment: .center, spacing: -30) {
            Button {
                onChooseOption1()
                resetIndicatorsShadows()
                HapticsManager.shared.complexSuccess()
                shadowRadius1 = 0
                shadowRadius2 = 0
            } label: {
                Assets.Images.optionScreen2.swiftUIImage
                    .resizable()
                    .frame(width: getWidth() * TapViewConstants.buttonWidthMultiplier,
                           height: getHeight() * TapViewConstants.buttonHeightMultiplier)
                    .padding()
                    .overlay(
                        Text(text1)
                            .font(.bodyFont)
                            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                            .padding(.horizontal, TapViewConstants.buttonPadding)
                    )
                    .shadow(color: Color.orange, radius: CGFloat(shadowRadius1))
                    .padding(.trailing, TapViewConstants.trailingPadding)
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: TapViewConstants.longPressMinimumDuration).onEnded { _ in
                    shadowRadius1 = Int(TapViewConstants.shadowRadius1)
                    shadowRadius2 = 0
                    resetIndicatorsShadows()
                    checkOptionIndicators(1)
                }
            )

            Button {
                onChooseOption2()
                resetIndicatorsShadows()
                HapticsManager.shared.complexSuccess()
                shadowRadius1 = 0
                shadowRadius2 = 0
            } label: {
                Assets.Images.optionScreen1.swiftUIImage
                    .resizable()
                    .frame(width: getWidth() * TapViewConstants.buttonWidthMultiplier,
                           height: getHeight() * TapViewConstants.buttonHeightMultiplier)
                    .padding()
                    .overlay(
                        Text(text2)
                            .font(.bodyFont)
                            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                            .padding(.horizontal, TapViewConstants.buttonPadding)
                    )
                    .shadow(color: Color.pink, radius: CGFloat(shadowRadius2))
                    .padding(.leading, TapViewConstants.leadingPadding)
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: TapViewConstants.longPressMinimumDuration).onEnded { _ in
                    shadowRadius1 = 0
                    shadowRadius2 = Int(TapViewConstants.shadowRadius1)
                    resetIndicatorsShadows()
                    checkOptionIndicators(2)
                }
            )
        }
    }
    
    private func checkOptionIndicators(_ option: Int) {
        let options = gameplayVM.getEvent()
        let eD = [options?.environmentalDegradation1, options?.environmentalDegradation2]
        let iB = [options?.illBeing1, options?.illBeing2]
        let sI = [options?.socioPoliticalInstability1, options?.socioPoliticalInstability2]
        
        if eD[option - 1] != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(TapViewConstants.shadowRadius2)
        }
        
        if iB[option - 1] != 0 {
            gameplayVM.illBeingShadowRadius = Int(TapViewConstants.shadowRadius2)
        }
        
        if sI[option - 1] != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(TapViewConstants.shadowRadius2)
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = Int(TapViewConstants.shadowResetValue)
        gameplayVM.illBeingShadowRadius = Int(TapViewConstants.shadowResetValue)
        gameplayVM.sociopoliticalInstabilityShadowRadius = Int(TapViewConstants.shadowResetValue)
    }
}

