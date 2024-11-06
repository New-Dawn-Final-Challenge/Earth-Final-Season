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
                    .font(Font.title3Font)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $settingsVM.musicIntensity, in: Constants.SettingsView.sliderRange)
                    Image(systemName: "speaker.wave.3.fill")
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Sound effects")
                    .font(Font.title3Font)
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "speaker.wave.1")
                    Slider(value: $settingsVM.soundEffectsIntensity, in: Constants.SettingsView.sliderRange)
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding()
            }
            
            HStack {
                Toggle("Haptics enabled", isOn: $settingsVM.hapticsEnabled)
                    .font(Font.title3Font)
                    .toggleStyle(SwitchToggleStyle(tint: Color.indigo))
                Spacer()
            }
            .padding(Constants.SettingsView.padding)
            
            if settingsVM.hapticsEnabled {
                VStack(alignment: .leading) {
                    Text("Haptics intensity")
                        .font(Font.title3Font)
                        .padding(.horizontal)
                        .onAppear {
                            withAnimation(.easeInOut(duration: Constants.SettingsView.transitionDuration)) {
                                sliderOpacity = 1
                            }
                        }
                        .onDisappear {
                            sliderOpacity = 0
                        }
                    HStack {
                        Slider(value: $settingsVM.hapticsIntensity, in: Constants.SettingsView.sliderRange)
                            .opacity(sliderOpacity)
                    }
                }
                .transition(.move(edge: .top))
                .padding()
            }
           
            VStack(alignment: .leading) {
                Text("Gesture")
                    .font(Font.title3Font)
                    .padding()
                Section {
                    VStack(alignment: .leading) {
                        Button {
                            settingsVM.selectedGesture = .holdDrag
                        } label: {
                            HStack {
                                Text("Hold and drag")
                                    .font(Font.bodyFont)
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(settingsVM.selectedGesture == .holdDrag ? 1 : 0)
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        Button {
                            settingsVM.selectedGesture = .tap
                        } label: {
                            HStack {
                                Text("Tap")
                                    .font(Font.bodyFont)
                                    Spacer()
                                Image(systemName: "checkmark")
                                    .opacity(settingsVM.selectedGesture == .tap ? 1 : 0)
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

enum Gesture: Int {
    case holdDrag
    case tap
}

extension AnyTransition {
    static var verticalSlide: AnyTransition {
        AnyTransition.move(edge: .top).combined(with: .opacity)
    }
}

