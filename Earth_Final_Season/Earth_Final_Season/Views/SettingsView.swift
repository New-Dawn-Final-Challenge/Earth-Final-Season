//
//  ConfigurationsView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settingsVM: SettingsViewModel
    @State private var sliderOpacity: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Music")
                    .font(.title3Font)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $settingsVM.musicIntensity, in: 0...100)
                    Image(systemName: "speaker.wave.3.fill")
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Sound effects")
                    .font(.title3Font)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $settingsVM.soundEffectsIntensity, in: 0...100)
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding()
            }
            
            HStack {
                Toggle("Haptics enabled", isOn: $settingsVM.hapticsEnabled)
                    .font(.title3Font)
                    .toggleStyle(SwitchToggleStyle(tint: .indigo))
                Spacer()
            }
            .padding(32)
            
            if (settingsVM.hapticsEnabled) {
                            VStack(alignment: .leading) {
                                Text("Haptics intensity")
                                    .font(.title3Font)
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
                                    Slider(value: $settingsVM.hapticsIntensity, in: 0...100)
                                        .opacity(sliderOpacity)
                                }
                            }
                            .transition(.move(edge: .top))
                            .padding()
                        }
           
            VStack(alignment: .leading) {
                Text("Gesture")
                    .font(.title3Font)
                    .padding()
                Section {
                    VStack(alignment: .leading) {
                        Button {
                            settingsVM.selectedGesture = .holdDrag
                        } label: {
                            HStack {
                                Text("Hold and drag")
                                    .font(.bodyFont)
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(settingsVM.selectedGesture == .holdDrag ? 1:0)
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        Button {
                            settingsVM.selectedGesture = .tap
                        } label: {
                            HStack {
                                Text("Tap")
                                    .font(.bodyFont)
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(settingsVM.selectedGesture == .tap ? 1.0:0.0)
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

enum Gesture {
    case holdDrag, tap
}

extension AnyTransition {
    static var verticalSlide: AnyTransition {
        AnyTransition.move(edge: .top).combined(with: .opacity)
    }
}
