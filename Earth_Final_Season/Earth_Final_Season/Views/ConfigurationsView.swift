//
//  ConfigurationsView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 27/09/24.
//

import SwiftUI

struct ConfigurationsView: View {
    @Binding var viewModel: ConfigurationsViewModel
    
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
            
            VStack(alignment: .leading) {
                Text("Haptics intensity")
                    .font(.title2)
                    .padding(.horizontal)
                HStack {
                    Slider(value: $viewModel.hapticsIntensity, in: 0...10)
                }
            }
            .padding()
            
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
            
        }
        .navigationTitle("Settings")
    }
}

//#Preview {
//    ConfigurationsView(viewModel: )
//}

enum Gesture {
    case holdDrag, tap
}
