//
//  ControlPanelView.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 08/11/24.
//

import SwiftUI
import Design_System

struct ControlPanelView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Binding var settingsVM: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                panelBackground
                
                VStack(alignment: .center) {
                    topPanelView
                        .padding(.bottom, -20)
                    
                    ZStack {
                        bottomPanelView
                        actionControlsView
                            .padding(.bottom, 40)
                    }
                }
            }
        }
    }
    
    private var staticPanelView: some View {
        HStack {
            Assets.Images.accessibilityPanel.swiftUIImage
                .resizable()
                .frame(width: getWidth() * Constants.GameplayView.staticPanelWidth,
                       height: getHeight() * Constants.GameplayView.staticPanelHeight)
        }
        .padding(.horizontal, Constants.GameplayView.panelHorizontalPadding)
        .padding(.top, Constants.GameplayView.panelPaddingTop)
    }
    
    private var panelAccessoryA: some View {
        VStack(spacing: 4) {
            Button {
                if let _ = gameplayVM.timer {
                    gameplayVM.isPaused.toggle()
                }
            } label: {
                Image(systemName: gameplayVM.isPaused ? "play.fill" : "pause.fill")
                    .resizable()
                    .frame(width: 20, height: 30)
                    .foregroundStyle(gameplayVM.getState() == .consequence ? Assets.Colors.accentSecondary.swiftUIColor : .secondary)
                    .shadow(color: .white, radius: gameplayVM.getState() == .consequence ? 4 : 0)
                    .aspectRatio(contentMode: .fit)
                    .animation(.linear)
                    .opacity(gameplayVM.getState() == .consequence ? 1 : 0.4)
            }
            .disabled(gameplayVM.getState() == .consequence ? false : true)
        
            
            Assets.Images.panelAccessoryA.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.75 * Constants.GameplayView.panelAccessoryWidthMultiplier,
                       height: getHeight() * 0.5 * Constants.GameplayView.panelAccessoryHeightMultiplier)
            
        }
    }
    
    private var panelAccessoryB: some View {
        VStack(spacing: 4) {
            Button {
                if let _ = gameplayVM.timer {
                    gameplayVM.countdown -= 6
                    gameplayVM.isPaused = false
                }
            } label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: 30, height: 35)
                    .foregroundStyle(gameplayVM.getState() == .consequence ? Assets.Colors.accentSecondary.swiftUIColor : .secondary)
                    .shadow(color: .white, radius: gameplayVM.getState() == .consequence ? 4 : 0)
                    .aspectRatio(contentMode: .fit)
                    .animation(.linear)
                    .opacity(gameplayVM.getState() == .consequence ? 1 : 0.4)
            }
            .disabled(gameplayVM.getState() == .consequence ? false : true)
            
                
            
            Assets.Images.panelAccessoryB.swiftUIImage
                .resizable()
                .frame(width: getWidth() * 0.75 * Constants.GameplayView.panelAccessoryWidthMultiplier,
                       height: getHeight() * 0.5 * Constants.GameplayView.panelAccessoryHeightMultiplier)
        }   
    }
    
    private var actionControlsView: some View {
        Group {
            if settingsVM.selectedGesture == .holdDrag {
                sliderControlView
            } else {
                staticPanelView
            }
        }
    }
    
    private var sliderControlView: some View {
        HStack {
            panelAccessoryA
            SliderView(
                onChooseOption1: { gameplayVM.chooseOption(option: 1) },
                onChooseOption2: { gameplayVM.chooseOption(option: 2) }
            )
            .grayscale(gameplayVM.getState() == .consequence ? 0.8 : 0)
            .colorMultiply(gameplayVM.getState() == .consequence ? .gray : .white)
            panelAccessoryB
        }
        .padding(.top, Constants.GameplayView.panelPaddingTop)
    }
    
    private var panelBackground: some View {
        Rectangle()
            .edgesIgnoringSafeArea(.all)
            .foregroundStyle(Assets.Colors.fillPrimary.swiftUIColor)
            .frame(width: getWidth() * 1,
                   height: getHeight() * Constants.BlackPanel.backgroundPanelHeight)
    }
    
    private var topPanelView: some View {
        HStack(spacing: Constants.BlackPanel.horizontalSpacing) {
            blackPanelItemView(Assets.Images.leftBlackPanel.swiftUIImage,
                               widthMultiplier: Constants.BlackPanel.sidePanelWidth,
                               padding: Constants.BlackPanel.sidePanelPadding)
            
            ZStack {
                blackPanelItemView(Assets.Images.yearBlackPanel.swiftUIImage,
                                   widthMultiplier: Constants.BlackPanel.yearPanelWidth)
                yearView
            }
            
            ZStack {
                blackPanelItemView(Assets.Images.indicatorsBlackPanel.swiftUIImage,
                                   widthMultiplier: Constants.BlackPanel.indicatorPanelWidth)
                indicatorsView
            }
            
            blackPanelItemView(Assets.Images.rightBlackPanel.swiftUIImage,
                               widthMultiplier: Constants.BlackPanel.sidePanelWidth,
                               padding: Constants.BlackPanel.sidePanelPadding)
        }
    }
    
    private var indicatorsView: some View {
        HStack(alignment: .center, spacing: getWidth() * Constants.GameplayView.indicatorSpacingMultiplier) {
            AudienceIndicatorView(percentage: CGFloat(Int(gameplayVM.getIndicators()?.audience ?? 0)))
            
            ChaosIndicatorsView(
                illBeing: gameplayVM.getIndicators()?.illBeing ?? 0,
                socioPoliticalInstability: gameplayVM.getIndicators()?.socioPoliticalInstability ?? 0,
                environmentalDegradation: gameplayVM.getIndicators()?.environmentalDegradation ?? 0
            )
        }
    }
    
    private var yearView: some View {
        Assets.Images.yearScreen.swiftUIImage
            .resizable()
            .frame(width: getWidth() * Constants.BlackPanel.yearMonitorWidth,
                   height: getHeight() * Constants.BlackPanel.yearMonitorHeight)
            .padding(.leading, Constants.BlackPanel.yearMonitorPadding)
            .overlay(
                Text("Year\n\(gameplayVM.getIndicators()?.currentYear ?? 0)")
                    .font(.title3Font)
                    .foregroundStyle(Assets.Colors.bgFillPrimary.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .padding(.leading, Constants.BlackPanel.yearMonitorPadding)
            )
    }
    
    private var bottomPanelView: some View {
        blackPanelItemView(Assets.Images.draggerBlackPanel.swiftUIImage,
                           widthMultiplier: Constants.BlackPanel.bottomPanelWidth)
    }
    
    private func blackPanelItemView(_ image: Image, widthMultiplier: CGFloat, padding: CGFloat? = nil) -> some View {
        image
            .resizable()
            .frame(width: getWidth() * widthMultiplier,
                   height: getHeight() * Constants.BlackPanel.panelHeight)
            .padding(.horizontal, padding ?? 0)
    }
}


#Preview {
    @Previewable @State var vm = SettingsViewModel()
    ControlPanelView(settingsVM: $vm)
        .environment(GameplayViewModel())
}
