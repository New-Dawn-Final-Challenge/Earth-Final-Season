//
//  SliderView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 30/09/24.
//

import SwiftUI
import CoreHaptics

struct SliderView: View {
    @Binding var mainScreenShadowRadius: Int
    @Binding var option1ShadowRadius: Int
    @Binding var option2ShadowRadius: Int
    
    var onChooseOption1: () -> Void
    var onChooseOption2: () -> Void
    
    @State private var dragOffset = CGSize.zero
    @State private var finalOffsetX: CGFloat = 0
    @State private var feedbackTrigger: CGPoint = .zero

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
                                // Calculate the new drag offset within the limits
                                finalOffsetX = min(max(gesture.translation.width, leftLimit), rightLimit)
                                dragOffset = CGSize(width: finalOffsetX, height: 0)

                                // Update the feedback trigger to the current drag location
                                feedbackTrigger = CGPoint(x: dragOffset.width, y: 0)

                                // Update shadow radius based on the circle's relative position within the slider
                                if finalOffsetX < 0 {
                                    option1ShadowRadius = Int(abs(finalOffsetX) / 6)
                                    option2ShadowRadius = 0
                                    
                                } else {
                                    option2ShadowRadius = Int(finalOffsetX / 6)
                                    option1ShadowRadius = 0
                                }
                                provideHapticFeedback()
                            }
                            .onEnded { _ in
                                withAnimation {
                                    // Option 1 chosen
                                    if finalOffsetX == leftLimit {
                                        HapticManager.shared.complexSuccess()
                                        onChooseOption1()
                                        mainScreenShadowRadius = 12
                                    }

                                    // Option 2 chosen
                                    else if finalOffsetX == rightLimit {
                                        HapticManager.shared.complexSuccess()
                                        onChooseOption2()
                                        mainScreenShadowRadius = 12
                                    }

                                    // Reset position and shadows
                                    dragOffset = .zero
                                    mainScreenShadowRadius = 0
                                    option1ShadowRadius = 0
                                    option2ShadowRadius = 0
                                }
                            }
                    )
            )
            .onAppear {
                prepareHaptics()
            }
            
    }
    
    // Prepare the CoreHaptics engine
        private func prepareHaptics() {
            HapticManager.shared.prepareHaptics()
        }

        // Function to provide haptic feedback
        private func provideHapticFeedback() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            let intense = HapticManager.shared.currentIntensity
            var events = [CHHapticEvent]()
            
            // Create a haptic pattern with medium impact
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.28 * intense)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
            
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try HapticManager.shared.engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play haptic: \(error.localizedDescription)")
            }
        }
    
}


