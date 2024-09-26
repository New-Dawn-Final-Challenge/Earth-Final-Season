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
            // main screen
            Text(optionToChoose)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                        .shadow(color: Color.blue, radius: CGFloat(mainScreenShadowRadius))
                )
                .frame(width: 300)
                .offset(y: 50)

            // option A
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

            // option B
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
            
            // slider/dragger
            ZStack {

                // set max width for slider
                let rectangleWidth = screenWidth * 1/2.5
                
                // slider
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: screenWidth * 1/2.5, height: 40)
                    .foregroundStyle(Color(UIColor.purple))
                
                // circle that can be dragged across the slider
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color(UIColor.systemPink))
                    .position(location)
                    .shadow(radius: 10)
                    .gesture(
                        DragGesture()
                            .onChanged { state in
                                // get the horizontal limits to which the circle can be dragged
                                let rightLimit = (screenWidth + rectangleWidth) / 2
                                let leftLimit = (screenWidth - rectangleWidth) / 2
                                
                                // set limit for the right side
                                if state.location.x > rightLimit {
                                    location = CGPoint(x: rightLimit, y: location.y)

                                }
                                
                                // set limit for the left side
                                else if state.location.x < leftLimit {
                                    location = CGPoint(x: leftLimit, y: location.y)
                                }
                                
                                // otherwise: move circle wherever its dragged
                                else {
                                    location = CGPoint(x: state.location.x, y: location.y)
                                }
                                
                                // if circle is on the second half of the slider, animate option B
                                if state.location.x > screenWidth/2 {
                                    withAnimation {
                                        optionBShadowRadius = Int(state.location.x)/10
                                        optionAShadowRadius = 0
                                    }
                                }
                                
                                // if circle is on the first half of the slider, animate option A
                                else {
                                    withAnimation {
                                        optionAShadowRadius = Int(screenWidth - state.location.x)/10
                                        optionBShadowRadius = 0
                                    }
                                }

                            }
                            .onEnded { state in
                                // get the horizontal limits to which the circle can be dragged
                                let rightLimit = (screenWidth + rectangleWidth) / 2
                                let leftLimit = (screenWidth - rectangleWidth) / 2

                                withAnimation {
                                    // option B was choosen
                                    if location.x == rightLimit {

                                        // trigger haptic
                                        complexSuccess()
                                        
                                        // animate main screen with blue shadow for 5 seconds
                                        // and show loading text
                                        optionToChoose = "Loading next command..."
                                        withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                                            mainScreenShadowRadius = 12
                                        }
                                        
                                        // after 6 seconds, show command to select other option
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                optionToChoose = "Choose option A"
                                                mainScreenShadowRadius = 0
                                            }
                                        }
                                        
                                    }
                                    
                                    // option A was choosen
                                    else if location.x == leftLimit {

                                        // trigger haptic
                                        complexSuccess()

                                        // animate main screen with blue shadow for 5 seconds
                                        // and show loading text
                                        optionToChoose = "Loading next command..."
                                        withAnimation(.easeInOut(duration: 1).repeatCount(5)) {
                                            mainScreenShadowRadius = 12
                                        }
                                        
                                        // after 6 seconds, show command to select other option
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                optionToChoose = "Choose option B"
                                                mainScreenShadowRadius = 0
                                            }
                                        }
                                    }
                                    
                                    // either way, after choice was made, set circle to the
                                    // center of the slider and turn off shadows
                                    location = CGPoint(x: screenWidth/2, y: 152)
                                    optionAShadowRadius = 0
                                    optionBShadowRadius = 0
                                }

                            }
                    )
            }
        }
        // enable haptics whenever sliding through the slider
        .sensoryFeedback(.impact(weight: .medium, intensity: 0.28), trigger: location)
        .offset(y: 100)
        // IMPORTANT: This is needed for the stronger haptics to work
        .onAppear(perform: prepareHaptics)
                    
    }
    
    // function that starts haptics engine
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine")
        }
    }
    
    // function that triggers strong haptics when a choice is made
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
