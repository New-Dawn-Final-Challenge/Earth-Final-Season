//
//  DraggerPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import CoreHaptics
import SwiftUI

struct DraggerPrototypeView: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var optionToChoose = "Choose option A"
    @State private var counter = 0
    @State private var currentOffset: CGFloat = .zero
    @State private var engine: CHHapticEngine?
    
    @State private var optionBShadowRadius = 0
    @State private var optionAShadowRadius = 0
    @State private var mainScreenShadowRadius = 0

    
    @State var location = CGPoint(x: UIScreen.main.bounds.width/2, y: 152)

    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Text(optionToChoose)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                        .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
                )
                .frame(width: 300)
                .offset(y: 50)
                        
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 360, height: 80)
                .foregroundStyle(Color(UIColor.systemGray2))
                .padding()
                .overlay(
                    Text("This is option A")
                        .foregroundStyle(Color.white)
                        .offset(x: 40)
                )
                .shadow(color: Color.pink, radius: CGFloat(optionAShadowRadius))
                .offset(x: -100, y: 120)

            RoundedRectangle(cornerRadius: 16)
                .frame(width: 360, height: 80)
                .foregroundStyle(Color(UIColor.systemGray2))
                .overlay(
                    Text("This is option B")
                        .foregroundStyle(Color.white)
                        .offset(x: -40)
                )
                .shadow(color: Color.pink, radius: CGFloat(optionBShadowRadius))
                .offset(x: 100, y: 110)
                            
            ZStack {
                let rectangleWidth = screenWidth * 1/2.5
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: screenWidth * 1/2.5, height: 40)
                    .foregroundStyle(Color(UIColor.purple))
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color(UIColor.systemPink))
                    .position(location)
                    .shadow(radius: 10)
                    .gesture(
                        DragGesture()
                            .onChanged { state in
                                var rightLimit = (screenWidth + rectangleWidth) / 2
                                var leftLimit = (screenWidth - rectangleWidth) / 2
                                
                                if state.location.x > rightLimit {
                                    location = CGPoint(x: rightLimit, y: location.y)

                                }
                                else if state.location.x < leftLimit {
                                    location = CGPoint(x: leftLimit, y: location.y)
                                }
                                else {
                                    location = CGPoint(x: state.location.x, y: location.y)
                                }
                                
                                if state.location.x > screenWidth/2 {
                                    withAnimation {
                                        optionBShadowRadius = Int(state.location.x)/10
                                        optionAShadowRadius = 0
                                    }
                                } else {
                                    withAnimation {
                                        optionAShadowRadius = Int(screenWidth - state.location.x)/10
                                        optionBShadowRadius = 0
                                    }
                                }

                            }
                            .onEnded { state in
                                var rightLimit = (screenWidth + rectangleWidth) / 2
                                var leftLimit = (screenWidth - rectangleWidth) / 2

                                withAnimation {
                                    if location.x == rightLimit {
                                        optionToChoose = "Loading next command..."
                                        complexSuccess()
                                        
                                        withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                                            mainScreenShadowRadius = 12
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                optionToChoose = "Choose option A"
                                                mainScreenShadowRadius = 0
                                            }
                                        }
                                        
                                    } else if location.x == leftLimit {
                                        optionToChoose = "Loading next command..."
                                        complexSuccess()

                                        withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                                            mainScreenShadowRadius = 12
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                optionToChoose = "Choose option B"
                                                mainScreenShadowRadius = 0
                                            }
                                        }
                                    }
                                    location = CGPoint(x: screenWidth/2, y: 152)
                                    optionAShadowRadius = 0
                                    optionBShadowRadius = 0
                                }

                            }
                    )
            }
        }
        .sensoryFeedback(.impact(weight: .medium, intensity: 0.28), trigger: location)
        .offset(y: 100)
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
    DraggerPrototypeView()
}
