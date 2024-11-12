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
        VStack(spacing: 12) {
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
                                .font(.bodyFont)
                                .padding(.leading, 36)
                            Spacer()
                        }
                        
                        gestureSelectionView
                        
                        Group {
                            Text("The standard gesture is ") +
                            Text("Hold and Drag").underline(true) +
                            Text(", while ") +
                            Text("Tap").underline(true) +
                            Text(" is recommended for accessibility")
                        }
                        .padding(.horizontal, 36)
                        .font(.footnoteFont)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 24)
                }
                .foregroundStyle(.black)
            
            resumeButton
            
            menuButton
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                .background(
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .fill(.black)
                )
        )
        .padding()
    }
    
    var musicView: some View {
        Assets.Images.musicSoundScreen.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                VStack(alignment: .leading) {
                    HStack(spacing: 12) {
                        Text("Music ")
                        Slider(value: $vm.musicIntensity, in: 0...100)
                            .tint(Assets.Colors.bgFillPrimary.swiftUIColor)
                    }
                    HStack(spacing: 12) {
                        Text("Sounds")
                        Slider(value: $vm.soundEffectsIntensity, in: 0...100)
                            .tint(Assets.Colors.bgFillPrimary.swiftUIColor)
                    }
                }
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .font(.bodyFont)
                .padding(.horizontal, 30)
            }
    }
    
    var hapticsView: some View {
        Assets.Images.hapticsScreen.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                HStack {
                    Toggle("Haptics", isOn: $vm.hapticsEnabled)
                        .font(.bodyFont)
                        .toggleStyle(SwitchToggleStyle(tint: Assets.Colors.bgFillPrimary.swiftUIColor))
                    Spacer()
                }
                .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
                .padding(.horizontal, 30)
            }
        
    }
    
    
    var gestureSelectionView: some View {
        Rectangle()
            .fill(Assets.Colors.bgFillPrimary.swiftUIColor)
            .clipShape(.rect(cornerRadius: Constants.Global.cornerRadius))
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
                        .overlay(Assets.Colors.accentPrimary.swiftUIColor)
                        .padding(.leading)
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
                .clipShape(RoundedRectangle(cornerRadius: Constants.Global.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
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
                .clipShape(RoundedRectangle(cornerRadius: Constants.Global.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                }
        }
        .padding(.horizontal, 30)
        .font(.bodyFont)
    }
    
}
