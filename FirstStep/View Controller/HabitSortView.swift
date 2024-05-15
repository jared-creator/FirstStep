//
//  HabitSortView.swift
//  FirstStep
//
//  Created by JaredMurray on 4/26/24.
//

import SwiftUI
import SwiftData

struct HabitSortView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Habits.startDate, order: .reverse), SortDescriptor(\Habits.startDate, order: .forward), SortDescriptor(\Habits.name, order: .reverse), SortDescriptor(\Habits.name, order: .forward)]) var habits: [Habits]
    
    @Query(sort: [SortDescriptor(\Goals.startDate, order: .reverse), SortDescriptor(\Goals.startDate, order: .forward), SortDescriptor(\Goals.name, order: .reverse), SortDescriptor(\Goals.name, order: .forward)]) var goals: [Goals]
    
    @Binding var tab: tabSelection
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        if tab == .habits {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(habits) { habits in
                        NavigationLink {
                            EditHabit(habit: habits)
                        } label: {
                            HabitCardView(habit: habits)
                        }
                    }
                }
            }
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(goals) { goals in
                        NavigationLink {
                            EditGoal(goal: goals)
                        } label: {
                            GoalCardView(goal: goals)
                        }
                    }
                }
            }
        }
    }
    
    init(sortHabit: SortDescriptor<Habits>, tab: Binding<tabSelection>) {
        _habits = Query(sort: [sortHabit])
        self._tab = tab
    }
    
    init(sortGoals: SortDescriptor<Goals>, tab: Binding<tabSelection>) {
        _goals = Query(sort: [sortGoals])
        self._tab = tab
    }
}
