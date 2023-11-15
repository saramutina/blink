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
    var isTimerRunning: Bool = false
    @Published var imageSwitchTimer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var session: WKExtendedRuntimeSession?
    private var workItem: DispatchWorkItem?
    private var startTime: Date?
    
    func startSession() {
        session = WKExtendedRuntimeSession()
        session?.delegate = self
        session?.start()
    }
    
    private func customTimer() {
        if isTimerRunning {
            workItem = DispatchWorkItem {
                self.customTimer()
            }
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .seconds(Int(secondsInterval)), execute: workItem!)
        }
        vibrate()
        stopAfterOneHour()
    }

    func startPlayingTicks() {
        startTime = Date.now
        imageSwitchTimer = Timer.publish(every: secondsInterval, on: .main, in: .common).autoconnect()
        isTimerRunning = true
        
        startSession()
        customTimer()
    }

    func stopPlayingTicks() {
        startTime = nil
        imageSwitchTimer = nil
        isTimerRunning = false
        
        workItem?.cancel()
        session?.invalidate()
        WKInterfaceDevice.current().play(.stop)
    }
    
    func stopAfterOneHour() {
        if (startTime != nil) && (Date.now > startTime! + 3600) {
            stopPlayingTicks()
            WKInterfaceDevice.current().play(.stop)
        }
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
