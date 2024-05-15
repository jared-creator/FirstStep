//
//  DateComponents+Ext.swift
//  FirstStep
//
//  Created by JaredMurray on 5/14/24.
//

import Foundation

extension DateComponents {
    func streakTime(habit startDate: Date) -> DateComponents {
        let currentDate: Date = .now
        let startDate = startDate
        let streak = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: currentDate)
        return streak
    }
}
