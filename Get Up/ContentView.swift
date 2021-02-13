//
//  ContentView.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  let name: String
}

struct ContentView: View {
    
    @State private var cards: [Card] = [Card(name: "alarm")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(cards) { card in
                    AlarmCard()
                        .padding([.top, .leading, .trailing])
                        .transition(.move(edge: .bottom))
                }
            }
            .navigationBarTitle("Get Up")
            .navigationBarItems(trailing: Button("Add", action: { self.cards.append(Card(name: String(cards.count))) }))
            .background(Image("bg") .resizable() .scaledToFill() .ignoresSafeArea())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
