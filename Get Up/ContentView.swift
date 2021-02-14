//
//  ContentView.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

let now = Date()

/* Main View */
struct ContentView: View {
    
    @State private var cards: [Alarm] = [Alarm(id: UUID(), date: Date(), isOn: true, isSnooze: false)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(cards) { card in
                    AlarmCard()
                        .padding([.top, .leading, .trailing])
                        .transition(.move(edge: .bottom))
                    
                }
                //getting error for parameters not found in AlarmEdit(), not working :(
//                .onTapGesture {
//                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .partialCurl) {
//                              AlarmEdit()
//                    }
//                }
            }
            .navigationBarTitle("Get Up")
            .navigationBarItems(trailing: Button("Add", action: { self.cards.append(Alarm(id: UUID(), date: Date(), isOn: false, isSnooze: false)) }))
            .background(Image("bg") .resizable() .scaledToFill() .ignoresSafeArea())
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
