////
////  SliderView.swift
////  Earth_Final_Season
////
////  Created by Larissa Fazolin on 27/09/24.
////
//
//import SwiftUI
//
//struct TestSliderView: View {
//    @Binding var optionToChoose: String
//    @Binding var mainScreenShadowRadius: Int
//    @Binding var optionAShadowRadius: Int
//    @Binding var optionBShadowRadius: Int
//    
//    @State private var dragOffset = CGSize.zero
//    @State private var finalOffsetX: CGFloat = 0
//    @State private var feedbackTrigger: CGPoint = .zero
//
//    var body: some View {
//        let sliderWidth = getWidth() * 0.5
//        let sliderHeight = getHeight() * 0.05
//        
//        let rightLimit = (sliderWidth / 2)
//        let leftLimit = -(sliderWidth / 2)
//
//        RoundedRectangle(cornerRadius: 16)
//            .frame(width: sliderWidth, height: sliderHeight)
//            .foregroundStyle(Color(UIColor.purple))
//            .overlay(
//                Circle()
//                    .foregroundStyle(Color(UIColor.systemPink))
//                    .padding(-6) // Set circle size
//                    .offset(dragOffset)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { gesture in
//                                // Calculate the new drag offset within the limits
//                                finalOffsetX = min(max(gesture.translation.width, leftLimit), rightLimit)
//                                dragOffset = CGSize(width: finalOffsetX, height: 0)
//
//                                // Update the feedback trigger to the current drag location
//                                feedbackTrigger = CGPoint(x: dragOffset.width, y: 0)
//
//                                // Update shadow radius based on the circle's relative position within the slider
//                                if finalOffsetX < 0 {
//                                    optionAShadowRadius = Int(abs(finalOffsetX) / 10)
//                                    optionBShadowRadius = 0
//                                    mainScreenShadowRadius = Int(abs(finalOffsetX) / 10)
//                                } else {
//                                    optionBShadowRadius = Int(finalOffsetX / 10)
//                                    optionAShadowRadius = 0
//                                    mainScreenShadowRadius = Int(finalOffsetX / 10)
//                                }
//                            }
//                            .onEnded { _ in
//                                withAnimation {
//                                    // Option A chosen
//                                    if finalOffsetX == leftLimit {
//                                        complexSuccess()
//                                        optionToChoose = "Loading next command..."
//                                        mainScreenShadowRadius = 12
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                                            withAnimation(.easeInOut(duration: 0.5)) {
//                                                optionToChoose = "Choose option B"
//                                                mainScreenShadowRadius = 0
//                                            }
//                                        }
//                                    }
//
//                                    // Option B chosen
//                                    else if finalOffsetX == rightLimit {
//                                        complexSuccess()
//                                        optionToChoose = "Loading next command..."
//                                        mainScreenShadowRadius = 12
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                                            withAnimation(.easeInOut(duration: 0.5)) {
//                                                optionToChoose = "Choose option A"
//                                                mainScreenShadowRadius = 0
//                                            }
//                                        }
//                                    }
//
//                                    // Reset position and shadows
//                                    dragOffset = .zero
//                                    optionAShadowRadius = 0
//                                    optionBShadowRadius = 0
//                                }
//                            }
//                    )
//            )
//            .sensoryFeedback(.impact(weight: .medium, intensity: 0.28), trigger: feedbackTrigger)
//    }
//}
