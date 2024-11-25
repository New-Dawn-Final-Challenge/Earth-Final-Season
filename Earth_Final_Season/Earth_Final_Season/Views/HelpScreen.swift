//
//  HelpScreen.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 22/11/24.
//

import SwiftUI
import Design_System

struct HelpScreen: View {
    var indicatorsSize: CGFloat = 50
    var title = "Instructions"
    var body: some View {
        ZStack {
            popUpBackground
            VStack(spacing: 6) {
                Text3dEffect(text: title)
                    .padding()
                
                VStack {
                    Text("Chaos indicators")
                        .font(.title1Font)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        
                    indicators
                    Text("Keep them high, \nbut never to their limit.")
                        .foregroundStyle(.white)
                        .font(.bodyFont)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text3dEffect(text: "Audience indicator")
                        .scaleEffect(0.75)
                    
                    audienceSection
                    
                    Text("Chaos indicators keep it high.\nIf it hits the bottom, you’re fired.")
                        .foregroundStyle(.white)
                        .font(.bodyFont)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
                
                
                Spacer()
            }
        }
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
        Group {
            HStack {
                Assets.Images.environmentalDegradationSimple.swiftUIImage
                    .resizable()
                    .frame(width: indicatorsSize, height: indicatorsSize)
                    .aspectRatio(contentMode: .fit)
                    .colorInvert()
                Spacer()
                Text("Environmental \ndegradation")
                    .font(.title3Font)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 60)
            
            HStack {
                Assets.Images.illbeingSimple.swiftUIImage
                    .resizable()
                    .frame(width: indicatorsSize, height: indicatorsSize)
                    .aspectRatio(contentMode: .fit)
                    .colorInvert()
                Spacer()
                Text("Ill-being     ")
                    .font(.title3Font)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 60)
            
            HStack {
                Assets.Images.socioPoliticalInstabilitySimple.swiftUIImage
                    .resizable()
                    .frame(width: indicatorsSize, height: indicatorsSize)
                    .aspectRatio(contentMode: .fit)
                    .colorInvert()
                Spacer()
                Text("Sociopolitical\ninstability")
                    .font(.title3Font)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 60)
        }
    }
    
    var audienceSection: some View {
        Group {
            Image(systemName: "hands.and.sparkles.fill")
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
            
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color(UIColor.systemGray))
                    .frame(width: getWidth() * Constants.AudienceIndicator.barWidthMultiplier,
                           height: getHeight() * Constants.AudienceIndicator.barHeightMultiplier)

                
                Rectangle()
                    .fill(Assets.Colors.textSecondary.swiftUIColor)
                    .frame(width: getWidth() * Constants.AudienceIndicator.barWidthMultiplier,
                           height: 20)
            }
            .cornerRadius(Constants.Global.cornerRadius)
        }
    }
}

#Preview {
    HelpScreen()
}
