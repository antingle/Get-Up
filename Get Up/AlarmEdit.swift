//
//  AlarmEdit.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

struct AlarmEdit: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @Binding var alarmIsOn:Bool
    @Binding var selectedActivity:String
    @Binding var wakeUp:Date
    @Binding var snooze:Bool
    @Binding var currentSeconds:Int
    @Binding var showDays:Bool
    
    @Binding var sun:Bool
    @Binding var mon:Bool
    @Binding var tue:Bool
    @Binding var wed:Bool
    @Binding var thu:Bool
    @Binding var fri:Bool
    @Binding var sat:Bool
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    //Wakeup Time
                    DatePicker(
                        "Wakeup Time",
                        selection: $wakeUp,
                        displayedComponents: [.hourAndMinute]) .labelsHidden()
//                    Text(wakeUp, style: .time).font(.system(size: 48, weight: .light)).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))).multilineTextAlignment(.center) .layoutPriority(50)
                    
                    Toggle("", isOn: $alarmIsOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color("ToggleColor")))
                }
                .padding([.top, .leading, .trailing])
                VStack {
                    
                   
                   
                    if showDays {
                        HStack {
                            Button(action: { sun.toggle() }, label: { Text("Sun") })
                            Button(action: { mon.toggle() }, label: { Text("Mon") })
                            Button(action: { tue.toggle() }, label: { Text("Tue") })
                            Button(action: { wed.toggle() }, label: { Text("Wed") })
                            Button(action: { thu.toggle() }, label: { Text("Thu") })
                            Button(action: { fri.toggle() }, label: { Text("Fri") })
                            Button(action: { sat.toggle() }, label: { Text("Sat") })
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
            .background(Color(#colorLiteral(red: 0.7490196228, green: 0.8313725591, blue: 0.8941176534, alpha: 0.8690773667)))
            .cornerRadius(20)
            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
            .accentColor(.black)
        }
    }
}


