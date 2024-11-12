//
//  SettingsModalView.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 31/10/24.
//

import SwiftUI
import Design_System

struct SettingsModalView: View {
    @Binding var vm: SettingsViewModel
    var doStuff: ()-> Void
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    Text3dEffect(text: "Settings")
                        .font(.largeTitleFont)
                    
                    musicView
                    
                    hapticsView
                    
                    Assets
                        .Images
                        .gestureScreen
                        .swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay {
                            VStack {
                                HStack {
                                    Text("Gesture")
                                        .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                                        .font(.title3Font)
                                        .padding(.leading, 36)
                                    Spacer()
                                }
                                
                                gestureSelectionView
                                
                                Group {
                                    Text("The standard gesture is ") +
                                    Text("Hold and Drag")
                                        .underline(true) +
                                    Text(", while Tap is recommended for accessibility")
                                }
                                .padding(.horizontal, 28)
                                .font(.footnoteFont)
                                .foregroundStyle(.secondary)
                            }
                        }
                        .foregroundStyle(.black)
                    
                    resumeButton
                    
                    menuButton
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.black)
                                .opacity(0.5)
                        )
                )
                .padding()
            }
            .padding()
        }
    }
    
    var musicView: some View {
        Assets.Images.musicSoundScreen.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                VStack {
                    HStack {
                        Text("Music ")
                        Slider(value: $vm.musicIntensity, in: 0...100)
                            .tint(Assets.Colors.bgFillPrimary.swiftUIColor)
                    }
                    HStack {
                        Text("Sounds")
                        Slider(value: $vm.soundEffectsIntensity, in: 0...100)
                            .tint(Assets.Colors.bgFillPrimary.swiftUIColor)
                    }
                }
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .font(.bodyFont)
                .padding(.horizontal, 46)
            }
    }
    
    var hapticsView: some View {
        Assets.Images.hapticsScreen.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                HStack {
                    Spacer()
                    Toggle("Haptics", isOn: $vm.hapticsEnabled)
                        .font(.bodyFont)
                        .toggleStyle(SwitchToggleStyle(tint: Assets.Colors.bgFillPrimary.swiftUIColor))
                    Spacer()
                }
                .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
                .padding(.horizontal, 46)
            }
        
    }
    
    
    var gestureSelectionView: some View {
        Rectangle()
            .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
            .clipShape(.rect(cornerRadius: 16))
            .frame(width: 240, height: 80)
            .overlay {
                VStack {
                    Button {
                        vm.selectedGesture = .holdDrag
                    } label: {
                        HStack {
                            Text("Hold and Drag")
                            Spacer()
                            Image(systemName: "checkmark")
                                .opacity(vm.selectedGesture == .holdDrag ? 1 : 0)
                        }
                        .padding(.horizontal)
                    }
                    Divider()
                        .padding(.horizontal)
                    Button {
                        vm.selectedGesture = .tap
                    } label: {
                        HStack {
                            Text("Tap")
                            Spacer()
                            Image(systemName: "checkmark")
                                .opacity(vm.selectedGesture == .tap ? 1 : 0)
                        }
                        .padding(.horizontal)
                    }
                }
                .font(.bodyFont)
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            }
    }
    
    var resumeButton: some View {
        Button {
            self.vm.isPresented.toggle()
        } label: {
            Text("Resume")
                .padding(16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 1)
                }
        }
        .padding(.horizontal, 30)
        .font(.bodyFont)
    }
    
    var menuButton: some View {
        Button {
            self.vm.isPresented.toggle()
            doStuff()
            
        } label: {
            Text("Menu")
                .padding(16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: 1)
                }
        }
        .padding(.horizontal, 30)
        .font(.bodyFont)
    }
    
}
