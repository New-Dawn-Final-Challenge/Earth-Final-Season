//
//  SliderView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI

struct SliderView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State private var dragOffset = CGSize.zero
    @State private var finalOffsetX: CGFloat = 0
    @State private var feedbackTrigger: CGPoint = .zero
    
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void

    var body: some View {
        let sliderWidth = getWidth() * 0.5
        let sliderHeight = getHeight() * 0.05
        
        let rightLimit = (sliderWidth / 2)
        let leftLimit = -(sliderWidth / 2)

        RoundedRectangle(cornerRadius: 16)
            .frame(width: sliderWidth, height: sliderHeight)
            .foregroundStyle(Color(UIColor.purple))
            .overlay(
                Circle()
                    .foregroundStyle(Color(UIColor.systemPink))
                    .padding(-6) // Set circle size
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                
                                if !gameplayVM.isShowingConsequence {
                                    // Calculate the new drag offset within the limits
                                    finalOffsetX = min(max(gesture.translation.width, leftLimit), rightLimit)
                                    dragOffset = CGSize(width: finalOffsetX, height: 0)

                                    // Update the feedback trigger to the current drag location
                                    feedbackTrigger = CGPoint(x: dragOffset.width, y: 0)

                                    // Update shadow radius based on the circle's relative position within the slider
                                    if finalOffsetX < 0 {
                                        gameplayVM.option1ShadowRadius = Int(abs(finalOffsetX) / 6)
                                        gameplayVM.option2ShadowRadius = 0
                                        
                                        resetIndicatorsShadows()
                                                   
                                        checkFirstOptionIndicators()
                                        
                                    } else {
                                        gameplayVM.option2ShadowRadius = Int(finalOffsetX / 6)
                                        gameplayVM.option1ShadowRadius = 0
                                        
                                        resetIndicatorsShadows()

                                        checkSecondOptionIndicators()
                                    }
                                }
                            }
                            .onEnded { _ in
                                if !gameplayVM.isShowingConsequence {
                                    withAnimation {
                                        // Option 1 chosen
                                        if finalOffsetX == leftLimit {
                                            HapticsManager.shared.complexSuccess()
                                            onChooseOption1()
                                            gameplayVM.mainScreenShadowRadius = 12
                                        }

                                        // Option 2 chosen
                                        else if finalOffsetX == rightLimit {
                                            HapticsManager.shared.complexSuccess()
                                            onChooseOption2()
                                            gameplayVM.mainScreenShadowRadius = 12
                                        }

                                        // Reset position and shadows
                                        resetIndicatorsShadows()
                                        dragOffset = .zero
                                        gameplayVM.mainScreenShadowRadius = 0
                                        gameplayVM.option1ShadowRadius = 0
                                        gameplayVM.option2ShadowRadius = 0
                                    }
                                }
                            }
                    )
            )
            .sensoryFeedback(.impact(weight: .medium, intensity: Double(HapticsManager.shared.intensity)*0.28), trigger: feedbackTrigger)
    }
    
    private func checkFirstOptionIndicators() {
        if gameplayVM.currentEvent?.environmentalDegradation1 != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.currentEvent?.illBeing1 != 0 {
            gameplayVM.illBeingShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.currentEvent?.socioPoliticalInstability1 != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(abs(finalOffsetX) / 10)
        }
    }
    
    private func checkSecondOptionIndicators() {
        if gameplayVM.currentEvent?.environmentalDegradation2 != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.currentEvent?.illBeing2 != 0 {
            gameplayVM.illBeingShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.currentEvent?.socioPoliticalInstability2 != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(abs(finalOffsetX) / 10)
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = 0
        gameplayVM.illBeingShadowRadius = 0
        gameplayVM.sociopoliticalInstabilityShadowRadius = 0
    }
}
