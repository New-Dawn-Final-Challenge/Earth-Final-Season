//
//  VideoView.swift
//  Earth_Final_Season
//
//  Created by Luan Fazolin on 13/11/24.
//

import AVKit
import SwiftUI
import Combine

struct VideoView: View {
    @Environment(GameplayViewModel.self) private var gameplayVM
    @Environment(\.dismiss) private var dismiss

    @Binding var menuVM: MenuViewModel
    @Binding var navigateToGameplay: Bool

    @State private var player: AVPlayer?
    @State private var playerObserver: AnyCancellable?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if let player = player {
                VideoPlayer(player: player)
                    .frame(width: getHeight(), height: getWidth())
                    .rotationEffect(.degrees(90))
                    .onAppear {
                        player.play()
                        addVideoEndObserver()
                    }
                    .onDisappear {
                        player.pause()
                        removeVideoEndObserver()
                    }
            }
        }
        .onAppear {
            player = AVPlayer(url: Bundle.main.url(forResource: gameplayVM.isPortuguese ? "introfilmBR" : "introfilm", withExtension: "mp4")!)
        }
    }

    private func addVideoEndObserver() {
        playerObserver = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
            .sink { _ in
                videoDidEnd()
            }
    }

    private func removeVideoEndObserver() {
        playerObserver?.cancel()
    }

    private func videoDidEnd() {
        menuVM.firstTimePlaying = false
        navigateToGameplay = true
        dismiss()
    }
}
