//
//  BlinkView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI

struct BlinkView: View {
    @Binding var isTimerOn: Bool
    var hapticsModel: HapticsModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "eye")
            Spacer()
            Button(action: {
                isTimerOn = false
                hapticsModel.stopPlayingTicks()
            }, label: {
                Text("Stop")
            })
        }
        .onAppear {
            
        }
    }
}

#Preview {
    BlinkView(isTimerOn: .constant(true), hapticsModel: HapticsModel())
}
