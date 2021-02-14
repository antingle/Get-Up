//
//  Alarm.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import Foundation

struct Alarm: Identifiable {
    var id: UUID
    var date: Date
    var isOn: Bool
    var isSnooze: Bool
    
    init(id: UUID = UUID(), date: Date, isOn: Bool, isSnooze: Bool) {
        self.id = id
        self.date = date
        self.isOn = isOn
        self.isSnooze = isSnooze
    }
}

extension Alarm {
    static var data: [Alarm] {
        [ Alarm(date: Date(), isOn: true, isSnooze: false) ]
    }
}
