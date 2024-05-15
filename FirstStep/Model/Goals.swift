//
//  Goals.swift
//  FirstStep
//
//  Created by JaredMurray on 5/14/24.
//

import Foundation
import SwiftData

@Model
class Goals {
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
