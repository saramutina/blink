//
//  HapticsModel.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import Foundation
import WatchKit

class HapticsModel: NSObject, ObservableObject {
    private var timer: Timer?
    private var session = WKExtendedRuntimeSession()

    private var isPlaying: Bool { timer != nil }

    private func startSessionIfNeeded() {
        guard !isPlaying, session.state != .running else { return }

        session = WKExtendedRuntimeSession()
        session.start()
    }

    private func stopSession() {
        session.invalidate()
    }

    private func tick(seconds: Double) {
        WKInterfaceDevice.current().play(.start)

        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false, block: { [weak self] (_) in
            self?.tick(seconds: seconds)
        })
    }

    func startPlayingTicks(seconds: Double) {
        timer?.invalidate()
        timer = nil

        startSessionIfNeeded()

        tick(seconds: seconds)
    }

    func stopPlayingTicks() {
        timer?.invalidate()
        timer = nil

        stopSession()
    }
}
