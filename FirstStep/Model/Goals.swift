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
/*

 Completion Rate: Users may be interested in their overall completion rate for each habit, indicating the percentage of times they've successfully completed the habit versus the total number of attempts.

 Frequency: Users may want to know how frequently they've performed a habit within a given timeframe (e.g., daily, weekly, monthly). This could be presented as a count of occurrences or a frequency distribution.

 Time Spent: For habits that involve time-based activities (e.g., exercise, reading), users may want to track the total time spent on each habit over time.

 Goal Progress: If users have set specific goals for their habits (e.g., exercising for 30 minutes a day), they may want to see their progress towards those goals, including how much they've achieved and how far they have to go.

 Trends Over Time: Users may be interested in seeing how their habits have evolved over time, including trends in completion rate, frequency, or goal progress. This could be visualized using charts or graphs.

 Comparisons: Users may want to compare their habits across different time periods, habits, or with other users. For example, they may want to compare their current streak with their longest streak or see how their completion rate for one habit compares to another.

 Impact on Mood or Productivity: Some habit tracking apps may include features to track users' mood or productivity alongside their habits. Users may want to see correlations between their habits and these metrics to better understand how their habits affect their overall well-being.

 Reminders and Notifications: Users may want statistics related to their interaction with reminders and notifications from the app, such as how often they engage with reminders and whether they're more likely to complete a habit when reminded.

 Achievements and Milestones: Users may enjoy earning achievements or reaching milestones within the app based on their habit tracking progress. Statistics related to achievements earned or progress towards milestones can be motivating for users.
 
 */
