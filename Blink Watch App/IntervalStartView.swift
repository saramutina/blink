//
//  IntervalStartView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI

struct IntervalStartView: View {
    @Binding var isTimerOn: Bool
    @State private var blinkInterval: Double = 4.0
    var hapticsModel: HapticsModel
    
    private var intervals: [Double] {
        var intervals: [Double] = []
        stride(from: 2.0, to: 16.0, by: 1.0).forEach { i in
            intervals.append(i)
        }
        return intervals
    }
    
    var body: some View {
        VStack {
            Text("Pick blink interval:")
            Picker("", selection: $blinkInterval) {
                ForEach(intervals, id: \.self) {
                    Text("\($0, specifier: "%.0f") seconds")
                }
            }
            Button(action: {
                isTimerOn = true
                hapticsModel.startPlayingTicks(seconds: blinkInterval)
            }, label: {
                Text("Start")
            })
        }
    }
}

#Preview {
    IntervalStartView(isTimerOn: .constant(false), hapticsModel: HapticsModel())
}
