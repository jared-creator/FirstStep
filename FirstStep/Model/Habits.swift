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
    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String = "", startDate: Date = .now, endDate: Date? = nil, cardColor: String = "", image: Data? = nil) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.cardColor = cardColor
        self.image = image
    }
}

