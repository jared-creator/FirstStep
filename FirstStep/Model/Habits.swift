//
//  Habits.swift
//  FirstStep
//
//  Created by JaredMurray on 4/17/24.
//

import Foundation
import SwiftData

@Model
class Habits {
    var name: String
    var startDate: Date
    var endDate: Date?
    var cardColor: String
    var habitType: HabitType
    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String = "", startDate: Date = .now, endDate: Date? = nil, cardColor: String = "", habitType: HabitType = .goodHabit, image: Data? = nil) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.cardColor = cardColor
        self.habitType = habitType
        self.image = image
    }
    
    func streakTime(habit startDate: Date) -> DateComponents {
        let currentDate: Date = .now
        let startDate = startDate
        let streak = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: currentDate)
        return streak
    }
    
    
}

enum HabitType: Codable {
    case goodHabit, badHabit
}

