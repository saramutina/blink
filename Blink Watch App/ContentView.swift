//
//  ContentView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var isTimerOn: Bool = false
    @State var hapticsModel = HapticsModel()
    
    var body: some View {
        NavigationView {
            if isTimerOn {
                BlinkView(isTimerOn: $isTimerOn, hapticsModel: hapticsModel)
            }  else {
                IntervalStartView(isTimerOn: $isTimerOn, hapticsModel: hapticsModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
