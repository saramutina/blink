//
//  ContentView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var isTimerOn: Bool = false
    @State var hapticsModel = HapticsModel.shared
    
    var body: some View {
        NavigationView {
            if isTimerOn {
                BlinkView(
                    hapticsModel: hapticsModel,
                    isTimerOn: $isTimerOn,
                    imageSwitchTimer: hapticsModel.imageSwitchTimer)
            }  else {
                IntervalStartView(
                    hapticsModel: hapticsModel,
                    isTimerOn: $isTimerOn,
                    blinkInterval: $hapticsModel.seconds,
                    vibrateHarder: $hapticsModel.vibrateHarder
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
