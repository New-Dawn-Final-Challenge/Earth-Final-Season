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

    private var sliderWidth: CGFloat { getWidth() * 0.4 }
    private var sliderHeight: CGFloat { getHeight() * 0.03 }
    private var rightLimit: CGFloat { sliderWidth / 2.5 }
    private var leftLimit: CGFloat { -(sliderWidth / 2.5) }

    var body: some View {
        SliderBarView(sliderWidth: sliderWidth, sliderHeight: sliderHeight)
            .overlay(
                VStack {
                    DraggerView(dragOffset: $dragOffset, feedbackTrigger: $feedbackTrigger)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    handleDragChanged(gesture)
                                }
                                .onEnded { _ in
                                    handleDragEnded()
                                }
                        )
                        .padding(.bottom, 30)
                    Spacer()
                }
            )
            .sensoryFeedback(
                .impact(weight: .medium, intensity: Double(HapticsManager.shared.intensity) * 0.28),
                trigger: feedbackTrigger
            )
    }

    private func handleDragChanged(_ gesture: DragGesture.Value) {
        guard gameplayVM.currentState != .consequence else { return }
        
        finalOffsetX = min(max(gesture.translation.width, leftLimit), rightLimit)
        dragOffset = CGSize(width: finalOffsetX, height: 0)
        feedbackTrigger = CGPoint(x: dragOffset.width, y: 0)
        
        updateShadowRadius()
    }

    private func handleDragEnded() {
        guard gameplayVM.currentState != .consequence else { return }
        
        withAnimation {
            if finalOffsetX == leftLimit {
                selectOption1()
            } else if finalOffsetX == rightLimit {
                selectOption2()
            } else {
                resetAll()
            }
        }
    }
    
    private func selectOption1() {
        HapticsManager.shared.complexSuccess()
        onChooseOption1()
        gameplayVM.mainScreenShadowRadius = 12
        resetAll()
    }

    private func selectOption2() {
        HapticsManager.shared.complexSuccess()
        onChooseOption2()
        gameplayVM.mainScreenShadowRadius = 12
        resetAll()
    }

    private func resetAll() {
        resetIndicatorsShadows()
        dragOffset = .zero
        gameplayVM.mainScreenShadowRadius = 0
        gameplayVM.option1ShadowRadius = 0
        gameplayVM.option2ShadowRadius = 0
    }

    // Updates shadow radius based on drag position
    private func updateShadowRadius() {
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

struct SliderBarView: View {
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    var body: some View {
        Assets.Images.sliderBar.swiftUIImage
            .resizable()
            .frame(width: sliderWidth, height: sliderHeight)
    }
}

struct DraggerView: View {
    @Binding var dragOffset: CGSize
    @Binding var feedbackTrigger: CGPoint
    
    var body: some View {
        Assets.Images.sliderDragger.swiftUIImage
            .resizable()
            .scaledToFit()
            .padding(-30)
            .offset(dragOffset)
    }
}
