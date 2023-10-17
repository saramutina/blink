//
//  HapticsModel.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import Foundation
import WatchKit
import Combine

class HapticsModel: NSObject, ObservableObject {
    @Published var seconds: Double = 4.0
    static let shared = HapticsModel()
    
    private var timer: Timer?
    var imageSwitchTimer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var session = WKExtendedRuntimeSession()

    private var isPlaying: Bool { timer != nil }

    func startSessionIfNeeded() {
        guard !isPlaying, session.state != .running else { return }

        session = WKExtendedRuntimeSession()
        session.start()
    }

    private func stopSession() {
        session.invalidate()
    }

    private func tick() {
        WKInterfaceDevice.current().play(.start)
        imageSwitchTimer = Timer.publish(every: seconds, on: .main, in: .common).autoconnect()

        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false, block: { [weak self] (_) in
            self?.tick()
        })
    }

    func startPlayingTicks(seconds: Double) {
        timer?.invalidate()
        timer = nil

        startSessionIfNeeded()

        tick()
    }

    func stopPlayingTicks() {
        timer?.invalidate()
        timer = nil
        imageSwitchTimer = nil

        stopSession()
    }
}

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func applicationDidBecomeActive() {
        // Restart WKExtendedRuntimeSession
        HapticsModel.shared.startSessionIfNeeded()
    }
}
