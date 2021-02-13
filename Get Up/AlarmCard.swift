//
//  AlarmCard.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

enum Activity: String, CaseIterable, Identifiable {
    case Puzzle
    case Shake
    case Math
    var id: String { self.rawValue }
}

struct AlarmCard: View {
    
    @State private var alarmIsOn = true
    @State private var selectedActivity = Activity.Puzzle.rawValue
    @State private var wakeUp = Date()
    @State private var snooze = false;
    @State private var currentSeconds = 3;
    @State private var showDays = false;
    
    let seconds = [5, 10, 15, 20]
    let days = ["S", "M", "T", "W", "Th", "F", "Sat"]
    
    var body: some View {
        VStack {
            VStack {
                Text("Alarm").bold().padding(.top)
                HStack {
                    //Wakeup Time
                    DatePicker(
                        "Wakeup Time",
                        selection: $wakeUp,
                        displayedComponents: [.hourAndMinute]) .labelsHidden()
                    
                    Toggle("", isOn: $alarmIsOn)
                        .toggleStyle(SwitchToggleStyle())
                }
                .padding([.top, .leading, .trailing])
                VStack {
                    
                    Button(action: { showDays.toggle() }, label: {
                        Text("M, T, W, Th, F")
                    })
                     
                    .padding(.bottom)
                    //Activity Picker
                    HStack {
                        Text("Activity:")
                        Picker(selectedActivity, selection: $selectedActivity) {
                            ForEach(Activity.allCases) { activity in
                                Text(activity.rawValue)
                            }
                        }
                        Picker(String(seconds[currentSeconds]) + " Seconds", selection: $currentSeconds) {
                            ForEach(0 ..< seconds.count) {
                                Text("\(self.seconds[$0]) Seconds")
                            }
                        }
                        .padding(.leading)
                        Spacer()
                        
                    } .pickerStyle(MenuPickerStyle())
                    
                    //Snooze Picker
                    HStack {
                        Text("Snooze:")
                        Button(action: {snooze.toggle()}, label: {
                            Text(String(snooze == true ? "On" : "Off"))
                        })
                        Spacer()
                    }
                    
                    
                }
                .padding([.leading, .bottom, .trailing])
            }
            .padding(.horizontal)
            .background(Color(#colorLiteral(red: 0.7490196228027344, green: 0.8313725590705872, blue: 0.8941176533699036, alpha: 1)))
            .cornerRadius(20)
         
        }
        
    }
}

struct AlarmCard_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCard()
    }
}
