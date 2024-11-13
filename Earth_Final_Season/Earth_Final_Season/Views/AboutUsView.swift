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
    var doStuff: ()-> Void
    
    init(vm: Binding<AboutUsViewModel>, text: String, doStuff: @escaping () -> Void) {
        print("Inicializando a VM")
        print(text)
        self._vm = vm
        self.doStuff = doStuff
    }

    var body: some View {
        ZStack {
            popUpBackground
            
            VStack(spacing: 24) {
                titleText
                descriptionText
                membersGrid(spacing: 40)
                buttonView(label: "Menu") {
                    vm.isPresentedInMenu.toggle()
                    doStuff()
                }
            }
            .foregroundStyle(Assets.Colors.textSecondary.swiftUIColor)
            .font(.bodyFont)
            .padding()
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
            .padding(.horizontal, 30)
    }
    
    private func memberImage(image: Image) -> some View {
        Assets.Images.characterScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * 0.25,
                   height: getHeight() * 0.12)
            .overlay(
                image
                    .resizable()
                    .padding(6)
            )
    }
    
    private func memberMonitor(for member: TeamMember) -> some View {
        VStack {
            memberImage(image: member.image)
            Text(member.name)
            Text(member.role)
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
                    .padding(.horizontal, -12)
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
