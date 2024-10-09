//
//  ConfigurationsView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import SwiftUI

struct ConfigurationsView: View {
    @State var viewModel: ConfigurationsViewModel
    @State private var sliderOpacity: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Music")
                    .font(.title2)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $viewModel.musicIntensity, in: 0...100)
                    Image(systemName: "speaker.wave.3.fill")
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Sound effects")
                    .font(.title2)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $viewModel.soundEffectsIntensity, in: 0...100)
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding()
            }
            
            HStack {
                Toggle("Haptics enabled", isOn: $viewModel.hapticsEnabled)
                    .font(.title2)
                    .toggleStyle(SwitchToggleStyle(tint: .indigo))
                Spacer()
            }
            .padding(32)
            
            if (viewModel.hapticsEnabled) {
                            VStack(alignment: .leading) {
                                Text("Haptics intensity")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            sliderOpacity = 1
                                        }
                                    }
                                    .onDisappear {
                                        sliderOpacity = 0
                                        }
                                HStack {
                                    Slider(value: $viewModel.hapticsIntensity, in: 0...100)
                                        .opacity(sliderOpacity)
                                }
                            }
                            .transition(.move(edge: .top))
                            .padding()
                        }
           
            VStack(alignment: .leading) {
                Text("Gesture")
                    .font(.title2)
                    .padding()
                Section {
                    VStack(alignment: .leading) {
                        Button {
                            viewModel.selectedGesture = .holdDrag
                        } label: {
                            HStack {
                                Text("Hold and drag")
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(viewModel.selectedGesture == .holdDrag ? 1:0)
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        Button {
                            viewModel.selectedGesture = .tap
                        } label: {
                            HStack {
                                Text("Tap")
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(viewModel.selectedGesture == .tap ? 1.0:0.0)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                }
                
                
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    ConfigurationsView(viewModel: ConfigurationsViewModel())
}

enum Gesture {
    case holdDrag, tap
}

extension AnyTransition {
    static var verticalSlide: AnyTransition {
        AnyTransition.move(edge: .top).combined(with: .opacity)
    }
}
