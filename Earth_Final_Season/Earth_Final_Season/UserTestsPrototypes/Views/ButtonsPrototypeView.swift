//
//  ButtonsPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import CoreHaptics
import SwiftUI
import Design_System

struct ButtonsPrototypeView: View {
    
    @State private var optionToChoose = "Choose option A"
    @State private var counter = 0
    @State private var optionAShadowRadius = 0
    @State private var optionBShadowRadius = 0
    @State private var engine: CHHapticEngine?
    @State private var mainScreenShadowRadius = 0


    var body: some View {
        VStack {
            Spacer()

            Text(optionToChoose)
                .font(.bodyFont)
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                        .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
                )
                .frame(width: 300)

            Spacer()

            Button(
                action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        optionAShadowRadius = 12
                    }
                    
                    complexSuccess()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            optionAShadowRadius = 0
                        }
                    }
                    
                    optionToChoose = "Loading next command..."
                    
                    withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                        mainScreenShadowRadius = 12
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            optionToChoose = "Choose option B"
                            mainScreenShadowRadius = 0
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
                                .font(.bodyFont)
                                .foregroundStyle(Color.white)
                        )
                        .shadow(color: Color.pink, radius: CGFloat(optionAShadowRadius))
                }
            )
            .padding(.bottom, -16)

            Button(
                action: {
                    withAnimation {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            optionBShadowRadius = 12
                        }
                        
                        complexSuccess()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                optionBShadowRadius = 0
                            }
                        }
                        
                        optionToChoose = "Loading next command..."
                        
                        withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                            mainScreenShadowRadius = 12
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                optionToChoose = "Choose option A"
                                mainScreenShadowRadius = 0
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
                                .font(.bodyFont)
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
