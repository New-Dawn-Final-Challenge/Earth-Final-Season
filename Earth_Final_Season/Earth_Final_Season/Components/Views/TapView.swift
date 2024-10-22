//
//  TapView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 21/10/24.
//

import SwiftUI

struct TapView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @State var shadowRadius1 = 0
    @State var shadowRadius2 = 0
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void
    var text1: String
    var text2: String
    var desiredOffset: Float = 28.0
    
    var body: some View {
        VStack(alignment: .center, spacing: -10) {
            Button {
                onChooseOption1()
                resetIndicatorsShadows()
                HapticsManager.shared.complexSuccess()
                shadowRadius1 = 0
                shadowRadius2 = 0
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: getWidth() * 0.9,
                           height: getHeight() * 0.10)
                    .foregroundStyle(Color(UIColor.systemGray4))
                    .padding()
                    .overlay(
                        Text(text1)
                            .foregroundStyle(Color.orange.gradient)
                            .padding(.horizontal, 30)
                    )
                    .shadow(color: Color.orange, radius: CGFloat(shadowRadius1))
                    .offset(x: -CGFloat(desiredOffset))
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1).onEnded {_ in

                    shadowRadius1 = 18
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
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: getWidth() * 0.9,
                           height: getHeight() * 0.10)
                    .foregroundStyle(Color(UIColor.systemGray4))
                    .padding()
                    .overlay(
                        Text(text2)
                            .foregroundStyle(Color.pink.gradient)
                            .padding(.horizontal, 30)
                    )
                    .offset(x: CGFloat(desiredOffset))
                    .shadow(color: Color.pink, radius: CGFloat(shadowRadius2))
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1).onEnded {_ in
                    shadowRadius1 = 0
                    shadowRadius2 = 18
                    resetIndicatorsShadows()
                               
                    checkOptionIndicators(2)
                }
            )
        }
    }
    
    private func checkOptionIndicators(_ option: Int) {
        let options = gameplayVM.getEvent()
        // swiftlint:disable min_length
        let eD = [options?.environmentalDegradation1, options?.environmentalDegradation2]
        let iB = [options?.illBeing1, options?.illBeing2]
        let sI = [options?.socioPoliticalInstability1, options?.socioPoliticalInstability2]
        
        if eD[option-1] != 0 {
            gameplayVM.environmentalDegradationShadowRadius = 14
        }
        
        if iB[option-1] != 0 {
            gameplayVM.illBeingShadowRadius = 14
        }
        
        if sI[option-1] != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = 14
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = 0
        gameplayVM.illBeingShadowRadius = 0
        gameplayVM.sociopoliticalInstabilityShadowRadius = 0
    }
}
