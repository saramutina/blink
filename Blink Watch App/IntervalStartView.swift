//
//  IntervalStartView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI

struct IntervalStartView: View {
    var hapticsModel: HapticsModel
    @Binding var isTimerOn: Bool
    @Binding var blinkInterval: Double
    @Binding var vibrateHarder: Bool
    
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
                    let key: String = "\(Int($0.rounded())) seconds"
                    Text(LocalizedStringKey(key))
                }
            }
            Button(action: {
                isTimerOn = true
                hapticsModel.startPlayingTicks()
            }, label: {
                Text("Start")
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink{
                    VStack {
                        Text("Vibration intensity:")
                        Picker("", selection: $vibrateHarder) {
                            Text("Gentle").tag(false)
                            Text("Harder").tag(true)
                        }
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
        
    }
}

#Preview {
    IntervalStartView(hapticsModel: HapticsModel(), isTimerOn: .constant(false), blinkInterval: .constant(4.0), vibrateHarder: .constant(true))
}
