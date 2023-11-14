//
//  HapticsModel.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import Foundation
import WatchKit
import Combine

class HapticsModel: WKExtendedRuntimeSession, ObservableObject {
    @Published var secondsInterval: Double = 4.0
    @Published var vibrateHarder: Bool = false
    static let shared = HapticsModel()
    private var session: WKExtendedRuntimeSession?
    var isTimerRunning: Bool = false

    @Published var imageSwitchTimer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    func startSession() {
        session = WKExtendedRuntimeSession()
        session?.delegate = self
        session?.start()
    }
    
    private func customTimer() {
        if isTimerRunning {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .seconds(Int(secondsInterval))) { [weak self] in
                self?.customTimer()
            }
        }
        vibrate()
    }

    func startPlayingTicks() {
        imageSwitchTimer = nil
        imageSwitchTimer = Timer.publish(every: secondsInterval, on: .main, in: .common).autoconnect()
        isTimerRunning = true
        
        startSession()
        customTimer()
    }

    func stopPlayingTicks() {

        imageSwitchTimer = nil
        isTimerRunning = false

        session?.invalidate()
    }
    
    @objc func vibrate() {
        if vibrateHarder {
            WKInterfaceDevice.current().play(.notification)
        } else {
            WKInterfaceDevice.current().play(.start)
        }
    }
}

extension HapticsModel: WKExtendedRuntimeSessionDelegate {
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        
    }
}
