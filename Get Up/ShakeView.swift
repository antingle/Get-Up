//
//  ShakeView.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

struct ShakeView: View {
    
    @State private var timeRemaining = 12
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var goBack = false
    
    var body: some View {
        VStack {
            //Rectangle
            Image(uiImage: #imageLiteral(resourceName: "Image"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 187)
                .clipped()
            .frame(width: 300, height: 300)
            //12 sec left
            Text("\(timeRemaining) sec left").font(.system(size: 72, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))).multilineTextAlignment(.center)
        }
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                goBack = true
            }
        } .fullScreenCover(isPresented: $goBack, content: {
            ContentView().preferredColorScheme(.dark)
        })
    }
}

struct ShakeView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeView().preferredColorScheme(.dark)
    }
}
