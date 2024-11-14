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
    @Environment(\.dismiss) private var dismiss

    @Binding var menuVM: MenuViewModel
    @Binding var navigateToGameplay: Bool


    private let player = AVPlayer(url: Bundle.main.url(forResource: "testfilm", withExtension: "mp4")!)
    @State private var playerObserver: AnyCancellable?

    var body: some View {
        ZStack {
            Color.black
            .ignoresSafeArea()
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
    
    private func addVideoEndObserver() {
        playerObserver = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
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
