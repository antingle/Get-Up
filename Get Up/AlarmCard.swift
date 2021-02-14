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
    case Match
    var id: String { self.rawValue }
}

var triggerAlarm = false

struct AlarmCard: View {
    
    @State var alarm = Alarm(date: Date(), isOn: false, isSnooze: false)
    @State var alarm1:Alarm?
//    @Binding private var alarmIsOn:Bool what is going on
    @State private var selectedActivity = Activity.Puzzle.rawValue
//    @Binding private var wakeUp:Date
    @State private var snooze = false
    @State private var currentSeconds = 3
    @State private var showDays = false
    @State private var showTime = false
    
    @State private var sun = false
    @State private var mon = true
    @State private var tue = true
    @State private var wed = true
    @State private var thu = true
    @State private var fri = true
    @State private var sat = false
    
    @State private var presentAlarm = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: { withAnimation {showTime.toggle()} }, label: {
                        Text(alarm.date, style: .time).font(.system(size: 48, weight: .light)).foregroundColor(showTime == true ? .blue : Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))).multilineTextAlignment(.center) .layoutPriority(50)
                    }) 
                    
                    Toggle("", isOn: $alarm.isOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color("ToggleColor")))
                        .onChange(of: alarm.isOn, perform: { value in
                            if alarm.isOn && alarm.date <= now {
                                presentAlarm = true
                            }
                        })
                        .fullScreenCover(isPresented: $presentAlarm, content: {
                            VStack {
                            Text(alarm.date, style: .time).font(.system(size: 72, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))).multilineTextAlignment(.center)
                            ShakeView()
                            } .ignoresSafeArea() .frame(width: 1000, height: 1000, alignment: .center).background(Color(.white)) // white background
                        })
                        
                }
                .padding([.top, .leading, .trailing])
                VStack {
                    
                    if showTime {
                    DatePicker(
                        "Wakeup Time",
                        selection: $alarm.date,
                        displayedComponents: [.hourAndMinute]).datePickerStyle(WheelDatePickerStyle()) .labelsHidden()
                        .transition(.scale) .colorScheme(.light) .onChange(of: alarm.date, perform: { value in
                            if value <= now && alarm.isOn {
                                presentAlarm = true
                            }
                        })
                        .fullScreenCover(isPresented: $presentAlarm, content: {
                            VStack {
                            Text(alarm.date, style: .time).font(.system(size: 72, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))).multilineTextAlignment(.center)
                            ShakeView()
                            } .ignoresSafeArea() .frame(width: 1000, height: 1000, alignment: .center).background(Color(.white)) // white background
                        })
                    }
                    
                    Button(action: { withAnimation { showDays.toggle() }}, label: {
                        Text(String(sun == true ? "S" : ""))
                        Text(String(mon == true ? "M" : ""))
                        Text(String(tue == true ? "T" : ""))
                        Text(String(wed == true ? "W" : ""))
                        Text(String(thu == true ? "Th" : ""))
                        Text(String(fri == true ? "F" : ""))
                        Text(String(sat == true ? "S" : ""))
                    }) .foregroundColor(showDays == true ? .blue : Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                    if showDays {
                        HStack {
                            Button(action: { sun.toggle() }, label: { Text("Sun") .foregroundColor(sun == true ? .black : .gray)})
                            Button(action: { mon.toggle() }, label: { Text("Mon") .foregroundColor(mon == true ? .black : .gray)})
                            Button(action: { tue.toggle() }, label: { Text("Tue") .foregroundColor(tue == true ? .black : .gray)})
                            Button(action: { wed.toggle() }, label: { Text("Wed") .foregroundColor(wed == true ? .black : .gray)})
                            Button(action: { thu.toggle() }, label: { Text("Thu") .foregroundColor(thu == true ? .black : .gray)})
                            Button(action: { fri.toggle() }, label: { Text("Fri") .foregroundColor(fri == true ? .black : .gray)})
                            Button(action: { sat.toggle() }, label: { Text("Sat") .foregroundColor(sat == true ? .black : .gray)})
                        }     .padding([.top, .bottom])
                    }
                    
                    //Activity Picker
                    HStack {
                        VStack {
                            Text("Activity")
                            //Shape
                            ZStack {
                                RoundedRectangle(cornerRadius: 2)
                                .fill(Color(#colorLiteral(red: 0.9795918464660645, green: 0.9795918464660645, blue: 0.9795918464660645, alpha: 1)))

                                RoundedRectangle(cornerRadius: 2)
                                .strokeBorder(Color(#colorLiteral(red: 0.661581814289093, green: 0.7336661219596863, blue: 0.7891156673431396, alpha: 0.8500000238418579)), lineWidth: 1.5)
                            
                            
                                Picker(selectedActivity, selection: $selectedActivity) {
                                    ForEach(Activity.allCases) { activity in
                                        Text(activity.rawValue)
                                    }
                                } .pickerStyle(MenuPickerStyle())
                            } .frame(width: 89.3, height: 22.7)
                        }
//                        Picker(String(seconds[currentSeconds]) + " Seconds", selection: $currentSeconds) {
//                            ForEach(0 ..< seconds.count) {
//                                Text("\(self.seconds[$0]) Seconds")
//                            }
//                        }
                        .padding(.leading)
                        Spacer()
                        VStack {
                            Text("Snooze")
                            //Shape
                            ZStack {
                                RoundedRectangle(cornerRadius: 2)
                                .fill(Color(#colorLiteral(red: 0.9795918464660645, green: 0.9795918464660645, blue: 0.9795918464660645, alpha: 1)))

                                RoundedRectangle(cornerRadius: 2)
                                .strokeBorder(Color(#colorLiteral(red: 0.661581814289093, green: 0.7336661219596863, blue: 0.7891156673431396, alpha: 0.8500000238418579)), lineWidth: 1.5)
                            
                            
                                Button(action: {snooze.toggle()}, label: {
                                    Text(String(snooze == true ? "Enabled" : "Disabled"))
                                })
                            } .frame(width: 89.3, height: 22.7)
                        }
                        
                    }
                    .padding(.all)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .background(alarm.isOn ? Color(#colorLiteral(red: 0.7490196228, green: 0.8313725591, blue: 0.8941176534, alpha: 0.8690773667)) : Color(#colorLiteral(red: 0.7490196228, green: 0.8313725591, blue: 0.8941176534, alpha: 0.7392124727)))
            .cornerRadius(20)
            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
            .accentColor(.black)
        }   .padding([.top, .leading, .trailing])
    }
}

struct AlarmCard_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCard().preferredColorScheme(.dark)
    }
}
