//
//  ButtonsPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import CoreHaptics
import SwiftUI

struct ButtonsPrototypeView: View {
    
    @State private var optionToChoose = "Choose option A"
    @State private var counter = 0
    @State private var optionAShadowRadius = 0
    @State private var optionBShadowRadius = 0
    @State private var engine: CHHapticEngine?


    var body: some View {
        VStack {
            Spacer()

            Text(optionToChoose)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                )

            Spacer()

            Button(
                action: {
                    withAnimation() {
                        if counter > 5 {
                            optionToChoose = "Great! That's enough"
                        } else {
                            optionToChoose = "Choose option B"
                        }
                        
                        counter += 1
                    }
                    withAnimation(.easeInOut(duration: 0.5)) {
                        optionAShadowRadius = 12
                    }
                    
                    complexSuccess()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            optionAShadowRadius = 0
                        }
                    }
                },
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("This is option A")
                                .foregroundStyle(Color.white)
                        )
                        .shadow(color: Color.pink, radius: CGFloat(optionAShadowRadius))
                }
            )
            .padding(.bottom, -16)

            Button(
                action: {
                    withAnimation {
                        if counter > 5 {
                            optionToChoose = "Great! That's enough"
                        } else {
                            optionToChoose = "Choose option A"
                        }
                        
                        counter += 1

                        withAnimation(.easeInOut(duration: 0.5)) {
                            optionBShadowRadius = 12
                        }
                        
                        complexSuccess()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                optionBShadowRadius = 0
                            }
                        }
                    }
                },
                label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360, height: 80)
                        .foregroundStyle(Color(UIColor.systemPink))
                        .padding()
                        .overlay(
                            Text("This is option B")
                                .foregroundStyle(Color.white)
                        )
                        .shadow(color: Color.pink, radius: CGFloat(optionBShadowRadius))
                }
            )
        }
        .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 0.01) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern")
        }
    }
}

#Preview {
    ButtonsPrototypeView()
}
