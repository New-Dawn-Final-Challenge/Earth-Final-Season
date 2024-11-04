//
//  SliderView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//
import SwiftUI
import Design_System

struct SliderView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    
    @State private var dragOffset = CGSize.zero
    @State private var finalOffsetX: CGFloat = 0
    @State private var feedbackTrigger: CGPoint = .zero
    
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void

    var body: some View {
        let sliderWidth = getWidth() * SliderViewConstants.widthMultiplier
        let sliderHeight = getHeight() * SliderViewConstants.heightMultiplier
        
        let rightLimit = (sliderWidth / SliderViewConstants.sliderLimitFactor)
        let leftLimit = -(sliderWidth / SliderViewConstants.sliderLimitFactor)

        Assets.Images.sliderBar.swiftUIImage
            .resizable()
            .frame(width: sliderWidth, height: sliderHeight)
            .overlay(
                VStack {
                    Assets.Images.sliderDragger.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(SliderViewConstants.draggerPadding) // Set dragger size
                        .offset(dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gameplayVM.currentState != .consequence {
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
                                    if gameplayVM.currentState != .consequence {
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
                        .padding(.bottom, 30)
                    Spacer()
                }
            )
            .sensoryFeedback(.impact(weight: .medium, intensity: Double(HapticsManager.shared.intensity) * SliderViewConstants.hapticFeedback), trigger: feedbackTrigger)
    }
    
    private func checkFirstOptionIndicators() {
        if gameplayVM.getEvent()?.environmentalDegradation1 != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.getEvent()?.illBeing1 != 0 {
            gameplayVM.illBeingShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.getEvent()?.socioPoliticalInstability1 != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(abs(finalOffsetX) / 10)
        }
    }
    
    private func checkSecondOptionIndicators() {
        if gameplayVM.getEvent()?.environmentalDegradation2 != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.getEvent()?.illBeing2 != 0 {
            gameplayVM.illBeingShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if gameplayVM.getEvent()?.socioPoliticalInstability2 != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(abs(finalOffsetX) / 10)
        }
    }
    
    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = 0
        gameplayVM.illBeingShadowRadius = 0
        gameplayVM.sociopoliticalInstabilityShadowRadius = 0
    }
}
