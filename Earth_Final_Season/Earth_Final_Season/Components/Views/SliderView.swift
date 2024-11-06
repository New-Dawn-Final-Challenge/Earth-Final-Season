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

    enum Option {
        case option1
        case option2
    }

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
                selectOption(.option1)
            } else if finalOffsetX == rightLimit {
                selectOption(.option2)
            } else {
                resetAll()
            }
        }
    }

    private func selectOption(_ option: Option) {
        HapticsManager.shared.complexSuccess()
        
        switch option {
        case .option1:
            onChooseOption1()
        case .option2:
            onChooseOption2()
        }
        
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

    private func updateShadowRadius() {
        if finalOffsetX < 0 {
            gameplayVM.option1ShadowRadius = Int(abs(finalOffsetX) / 6)
            gameplayVM.option2ShadowRadius = 0
            resetIndicatorsShadows()
            checkOptionIndicators(for: .option1)
        } else {
            gameplayVM.option2ShadowRadius = Int(finalOffsetX / 6)
            gameplayVM.option1ShadowRadius = 0
            resetIndicatorsShadows()
            checkOptionIndicators(for: .option2)
        }
    }

    private func checkOptionIndicators(for option: Option) {
        let event = gameplayVM.getEvent()
        
        let degradation = (option == .option1) ? event?.environmentalDegradation1 : event?.environmentalDegradation2
        let illBeing = (option == .option1) ? event?.illBeing1 : event?.illBeing2
        let instability = (option == .option1) ? event?.socioPoliticalInstability1 : event?.socioPoliticalInstability2
        
        if degradation != 0 {
            gameplayVM.environmentalDegradationShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if illBeing != 0 {
            gameplayVM.illBeingShadowRadius = Int(abs(finalOffsetX) / 10)
        }
        
        if instability != 0 {
            gameplayVM.sociopoliticalInstabilityShadowRadius = Int(abs(finalOffsetX) / 10)
        }
    }

    private func resetIndicatorsShadows() {
        gameplayVM.environmentalDegradationShadowRadius = 0
        gameplayVM.illBeingShadowRadius = 0
        gameplayVM.sociopoliticalInstabilityShadowRadius = 0
    }
}
