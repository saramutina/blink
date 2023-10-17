//
//  BlinkView.swift
//  Blink Watch App
//
//  Created by Katie Saramutina on 16.10.2023.
//

import SwiftUI
import Combine

struct BlinkView: View {
    @Binding var isTimerOn: Bool
    var hapticsModel: HapticsModel
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
                    withAnimation(Animation.easeOut){
                        self.imageToShow = "eyeClosed"
                    }
                    withAnimation(Animation.easeOut.delay(0.5)) {
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
    BlinkView(isTimerOn: .constant(true), hapticsModel: HapticsModel(), imageSwitchTimer: Timer.publish(every: 4, on: .main, in: .common).autoconnect())
}
