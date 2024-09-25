//
//  DraggerPrototypeView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 24/09/24.
//

import SwiftUI

struct DraggerPrototypeView: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var optionToChoose = "Choose option A"
    @State private var counter = 0
    @State private var currentOffset: CGFloat = .zero
    
    @State private var optionBShadowRadius = 0
    @State private var optionAShadowRadius = 0
    
    @State var location = CGPoint(x: UIScreen.main.bounds.width/2, y: 162)

    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Text(optionToChoose)
                .padding(100)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(UIColor.systemGray4))
                )
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
                                        optionBShadowRadius = Int(state.location.x)/20
                                        optionAShadowRadius = 0
                                    }
                                } else {
                                    withAnimation {
                                        optionAShadowRadius = Int(state.location.x)/10
                                        optionBShadowRadius = 0
                                    }
                                }

                            }
                            .onEnded { state in
                                var rightLimit = (screenWidth + rectangleWidth) / 2
                                var leftLimit = (screenWidth - rectangleWidth) / 2

                                withAnimation {
                                    if location.x == rightLimit {
                                        optionToChoose = "Choose option A"
                                    } else if location.x == leftLimit {
                                        optionToChoose = "Choose option B"
                                    }
                                    location = CGPoint(x: screenWidth/2, y: 162)
                                    optionAShadowRadius = 0
                                    optionBShadowRadius = 0
                                }

                            }
                    )
            }
        }
        .offset(y: 100)
                    
    }
}


#Preview {
    DraggerPrototypeView()
}
