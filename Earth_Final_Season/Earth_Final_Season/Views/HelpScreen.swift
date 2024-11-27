import SwiftUI
import Design_System

struct HelpScreen: View {
    @Binding var vm: SettingsViewModel
    var indicatorsSize: CGFloat = 30
    var title = "Instructions"
    
    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: 0) {
                Text3dEffect(text: title)
                    .font(.largeTitleFont)
                
                Text("Keep the show running for as many years as you can!")
                    .foregroundStyle(.white)
                    .font(.title3Font)
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.center)
                
                indicators
                    .padding(.vertical, 8)
                
                audienceSection
                    .padding(.vertical, 8)
                
                resumeButton
                
                Spacer()
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
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Chaos indicators")
                        .font(.title3Font)
                        .foregroundStyle(.black)
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Assets.Images.environmentalDegradationSimple.swiftUIImage
                            .resizable()
                            .frame(width: indicatorsSize, height: indicatorsSize)
                            .aspectRatio(contentMode: .fit)
                            .colorInvert()
                            .padding(.leading, 16)
                            .padding(.top, 4)
                            .padding(.trailing, 8)
                        
                        VStack {
                            Text("Environmental\ndegradation")
                                .font(.footnoteFont)
                                .foregroundStyle(.white)
                        }
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
                            Text("Ill-being")
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
                            Text("Sociopolitical\ninstability")
                                .font(.footnoteFont)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    
                    
                }
                .background(
                    Rectangle()
                        .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
                        .clipShape(.rect(cornerRadius: Constants.Global.cornerRadius))
                )
                .frame(maxWidth: 250)
                
                HStack {
                    Text("Keep them ") +
                    Text("high")
                        .underline() +
                    Text(", but never to their limit")
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
            
            VStack(spacing: 4) {
                HStack {
                    Spacer()
                    Text("Audience indicator")
                        .font(.title3Font)
                        .foregroundStyle(.black)
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    Image(systemName: "hands.and.sparkles.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 35, height: 40)
                        .padding(.horizontal, 12)
                        .padding(.top, 8)
                    
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: getWidth() * Constants.AudienceIndicator.barWidthMultiplier * 1.25,
                                   height: getHeight() * 1.25 * Constants.AudienceIndicator.barHeightMultiplier)
                            .cornerRadius(Constants.Global.cornerRadius)
                        
                        Rectangle()
                            .fill(Assets.Colors.textSecondary.swiftUIColor)
                            .frame(width: getWidth() * 1.25 * Constants.AudienceIndicator.barWidthMultiplier,
                                   height: 20 * 1.25)
                            .cornerRadius(Constants.Global.cornerRadius)
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
                }
                .background(
                    Rectangle()
                        .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
                        .clipShape(.rect(cornerRadius: Constants.Global.cornerRadius))
                )
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Audience is high if ") +
                    Text("chaos is high")
                        .underline() +
                    Text(". If it hits the bottom, ") +
                    Text("you're fired")
                        .underline()
                }
                    .font(.footnoteFont)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 54)
            }
        }
    }
    
    var resumeButton: some View {
        Button {
            self.vm.isPresentedHelp.toggle()
        } label: {
            Text("Resume")
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
