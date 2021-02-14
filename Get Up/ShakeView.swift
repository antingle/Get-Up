//
//  ShakeView.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI
import AVFoundation

struct ShakeView: View {
    
    @State private var timeRemaining = 12
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var goBack = false
    @State var audioPlayer: AVAudioPlayer!
    @State var isAnimating = false
    
    var body: some View {
        VStack {
            
            //Rectangle
            Image(uiImage: #imageLiteral(resourceName: "Image"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 248)
                .clipped()
                .frame(width: 300, height: 300)
                .rotationEffect(self.isAnimating ? Angle(degrees: -10): Angle(degrees: 10))
                .scaleEffect(self.isAnimating ? 1 : 1.3)
                .animation(Animation.linear(duration: 0.3).repeatForever())
                .onAppear {
                                self.isAnimating = true // <2>
                        }
            //12 sec left
            Text("\(timeRemaining) sec left").font(.system(size: 72, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))).multilineTextAlignment(.center)
        } .onAppear(perform: {
            playSounds("alarm.mp3")
            audioPlayer.numberOfLoops = 2
        })
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                goBack = true
                audioPlayer.stop()
            }
        } .fullScreenCover(isPresented: $goBack, content: {
            ContentView().preferredColorScheme(.dark)
        })
    }
    //Alarm sounds
    func playSounds(_ soundFileName : String) {
           guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
               fatalError("Unable to find \(soundFileName) in bundle")
           }

           do {
               audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
           } catch {
               print(error.localizedDescription)
           }
           audioPlayer.play()
       }
}

struct ShakeView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeView().preferredColorScheme(.dark)
    }
}
