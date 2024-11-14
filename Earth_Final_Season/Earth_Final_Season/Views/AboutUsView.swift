//
//  AboutUsView.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 09/10/24.
//

import SwiftUI
import Design_System

struct AboutUsView: View {
    @Binding var vm: AboutUsViewModel
    @State private var triggerGlitch = false
    var doStuff: () -> Void

    init(vm: Binding<AboutUsViewModel>, text: String, doStuff: @escaping () -> Void) {
        print("Inicializando a VM")
        print(text)
        self._vm = vm
        self.doStuff = doStuff
    }

    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: Constants.AboutUsView.vstackSpacing) {
                titleText
                descriptionText
                membersGrid(spacing: Constants.AboutUsView.membersGridSpacing)
                buttonView(label: "Menu") {
                    vm.isPresentedInMenu.toggle()
                    doStuff()
                }
            }
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .font(.bodyFont)
            .padding()
            .onAppear {
                triggerGlitch = true
                SoundtrackAudioManager.shared.playSoundEffect(named: "changeCharacter", fileExtension: "wav", volume: 0.15)
            }
        }
        .padding()
    }

    private var popUpBackground: some View {
        RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
            .stroke(Assets.Colors.accentPrimary.swiftUIColor,
                    lineWidth: Constants.Global.lineWidth)
            .background(
                RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                    .foregroundStyle(Color.black)
            )
    }
    
    private var titleText: some View {
        Text3dEffect(text: "About Us")
    }
    
    private var descriptionText: some View {
        Text("This game was developed at the Apple Developer Academy")
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .font(.bodyFont)
            .multilineTextAlignment(.center)
            .padding(.horizontal, Constants.AboutUsView.descriptionTextPadding)
    }
    
    private func memberImage(image: Image) -> some View {
        Assets.Images.characterScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.AboutUsView.gameImageWidth,
                   height: getHeight() * Constants.AboutUsView.gameImageHeight)
            .overlay(
                GlitchContentView(trigger: $triggerGlitch, uiImage: image)
                    .padding(Constants.AboutUsView.gameImagePadding)
            )
    }

    
    private func memberMonitor(for member: TeamMember) -> some View {
        VStack {
            memberImage(image: member.image)
            HackerTextView(text: member.name, speed: 0.05)
            HackerTextView(text: member.role, speed: 0.05)
        }
        .font(.footnoteFont)
    }
    
    private func membersGrid(spacing: CGFloat) -> some View {
        VStack {
            HStack(spacing: spacing) {
                memberMonitor(for: .elisa)
                memberMonitor(for: .breno)
            }
            HStack(spacing: spacing) {
                memberMonitor(for: .bruna)
                memberMonitor(for: .lariF)
            }
            HStack(spacing: spacing) {
                memberMonitor(for: .lariO)
                    .padding(.horizontal, Constants.AboutUsView.membersGridPadding)
                memberMonitor(for: .luan)
            }
        }
    }
    
    private func buttonView(label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .padding()
                .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
                .frame(maxWidth: .infinity)
                .background(Assets.Colors.bgFillPrimary.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.Global.cornerRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.Global.cornerRadius)
                        .stroke(Assets.Colors.accentPrimary.swiftUIColor, lineWidth: Constants.Global.lineWidth)
                }
        }
        .padding(.horizontal)
        .font(.bodyFont)
    }
}
