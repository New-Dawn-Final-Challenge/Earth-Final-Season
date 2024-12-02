import SwiftUI
import Design_System

struct HelpScreen: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var vm: SettingsViewModel
    var indicatorsSize: CGFloat = 30
    let percentage: CGFloat = 5
    
    var body: some View {
        let title = gameplayVM.isPortuguese ? "Instruções" : "Instructions"
        
        ZStack {
            popUpBackground
            
            VStack(spacing: 6) {
                Text3dEffect(text: title)
                    .font(.largeTitleFont)
                
                Text(gameplayVM.isPortuguese ? "Mantenha o show no ar pelo maior número de anos possível!" : "Keep the show running for as many years as you can!")
                    .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                    .font(.bodyFont)
                    .multilineTextAlignment(.center)
                
                indicators
                
                audienceSection
                
                resumeButton
            }
            .padding()
        }
        .padding()
    }
    
    var popUpBackground: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: Constants.Global.lineWidth)
            .background(
                RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                    .foregroundStyle(Color.black)
            )
    }
    
    var indicators: some View {
        ZStack {
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: getHeight() * 0.33)
            
            VStack {
                HStack {
                    HackerTextView(text: gameplayVM.isPortuguese ? "Indicadores de Caos" : "Chaos Indicators", speed: 0.05)
                        .font(.bodyFont)
                        .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
                    Spacer()
                }
                .padding(.leading, 36)
                
                VStack {
                    HStack {
                        Assets.Images.environmentalDegradationSimple.swiftUIImage
                            .resizable()
                            .frame(width: indicatorsSize, height: indicatorsSize)
                            .aspectRatio(contentMode: .fit)
                            .colorInvert()
                            .padding(.leading, 16)
                            .padding(.top, 6)
                            .padding(.trailing, 8)
                        
                        VStack {
                            HackerTextView(text: gameplayVM.isPortuguese ? "Degradação" : "Environmental", speed: 0.05)
                            HackerTextView(text: gameplayVM.isPortuguese ? "ambiental " : "degradation  ", speed: 0.05)
                        }
                        .font(.footnoteFont)
                        .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .overlay(Assets.Colors.accentPrimary.swiftUIColor)
                    
                    HStack {
                        Assets.Images.illbeingSimple.swiftUIImage
                            .resizable()
                            .frame(width: indicatorsSize, height: indicatorsSize)
                            .aspectRatio(contentMode: .fit)
                            .colorInvert()
                            .padding(.leading, 16)
                            .padding(.top, 4)
                            .padding(.bottom, 4)
                            .padding(.trailing, 8)
                        
                        VStack {
                            HackerTextView(text: gameplayVM.isPortuguese ? "Mal-estar" : "Ill-being", speed: 0.05)
                                .font(.footnoteFont)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .overlay(Assets.Colors.accentPrimary.swiftUIColor)
                    
                    HStack {
                        Assets.Images.socioPoliticalInstabilitySimple.swiftUIImage
                            .resizable()
                            .frame(width: indicatorsSize, height: indicatorsSize)
                            .aspectRatio(contentMode: .fit)
                            .colorInvert()
                            .padding(.leading, 16)
                            .padding(.bottom, 8)
                            .padding(.trailing, 8)
                        
                        VStack {
                            HackerTextView(text: gameplayVM.isPortuguese ? "Instabilidade\nsociopolítica" : "Sociopolitical\ninstability", speed: 0.05)
                                .font(.footnoteFont)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    
                    
                }
                .padding(4)
                .background(
                    Rectangle()
                        .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
                        .clipShape(.rect(cornerRadius: Constants.Global.cornerRadius))
                )
                .frame(maxWidth: 250)
                
                HStack {
                    HackerTextView(text: gameplayVM.isPortuguese ? "Mantenha eles altos, mas nunca nos seus limites" : "Keep them high, but never to their limit", speed: 0.05)
                }
                .font(.footnoteFont)
                .foregroundStyle(.gray)
                .padding(.horizontal, 36)
            }
        }
    }
    
    var audienceSection: some View {
        ZStack {
            Assets.Images.characterScreen.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            VStack {
                HStack {
                    HackerTextView(text: gameplayVM.isPortuguese ? "Indicador de Audiência" : "Audience Indicator", speed: 0.05)
                        .font(.bodyFont)
                        .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
                    Spacer()
                }
                .padding(.leading, 36)
                
                VStack {
                    Image(systemName: "hands.and.sparkles.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 30)
                        .padding(.horizontal, 12)
                        .padding(.top, 8)
                    
                    ZStack(alignment: .bottom) {
                        // Background Bar (empty part)
                        Rectangle()
                            .fill(Color(UIColor.systemGray))
                            .frame(width: getWidth() * 1.35 *  Constants.AudienceIndicator.barWidthMultiplier,
                                   height: getHeight() *  Constants.AudienceIndicator.barHeightMultiplier)
                        
                        
                        Rectangle()
                            .fill(Assets.Colors.textSecondary.swiftUIColor)
                            .frame(width: getWidth() * 1.35 *  Constants.AudienceIndicator.barWidthMultiplier,
                                   height: max(0, CGFloat(percentage - Constants.AudienceIndicator.percentageOffset) / Constants.AudienceIndicator.percentageScaleFactor * (getHeight() * Constants.AudienceIndicator.barHeightMultiplier)))
                    }
                    .cornerRadius(Constants.Global.cornerRadius)
                    .padding(.bottom, 8)
                }
                .background(
                    Rectangle()
                        .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
                        .clipShape(.rect(cornerRadius: Constants.Global.cornerRadius))
                )
                .frame(maxWidth: .infinity)
                
                HStack {
                    HackerTextView(text: gameplayVM.isPortuguese ? "A audiência fica alta se o caos estiver alto. Se ela chegar no mínimo, você está demitido" : "Audience is high if chaos is high. If it hits the bottom, you're fired", speed: 0.05)
                }
                    .font(.footnoteFont)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 54)
            }
        }
    }
    
    var resumeButton: some View {
        Button {
            self.vm.isPresentedHelp.toggle()
        } label: {
            Text(gameplayVM.isPortuguese ? "Continuar" : "Resume")
                .padding(16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.Global.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                }
        }
        .padding(.horizontal, 30)
        .font(.bodyFont)
    }
}
