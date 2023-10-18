//
//  BlinkView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI
import Combine

struct BlinkView: View {
    var hapticsModel: HapticsModel
    @Binding var isTimerOn: Bool
    var imageSwitchTimer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    @State var imageToShow: String = "eyeOpen"
    
    
    var body: some View {
        VStack {
            Spacer()
            Image(imageToShow)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.8)
                .onReceive(imageSwitchTimer!) { _ in
                    self.imageToShow = "eyeClosed"
                    withAnimation(Animation.default.delay(0.5)) {
                        self.imageToShow = "eyeOpen"
                    }
                }
            Spacer()
            Button(action: {
                isTimerOn = false
                hapticsModel.stopPlayingTicks()
            }, label: {
                Text("Stop")
            })
        }
    }
}

#Preview {
    BlinkView(hapticsModel: HapticsModel(), isTimerOn: .constant(true), imageSwitchTimer: Timer.publish(every: 4, on: .main, in: .common).autoconnect())
}
