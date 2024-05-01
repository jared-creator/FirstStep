//
//  HabitSortView.swift
//  FirstStep
//
//  Created by JaredMurray on 4/26/24.
//

import SwiftUI
<<<<<<< HEAD

struct HabitSortView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HabitSortView()
=======
import SwiftData

struct HabitSortView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Habits.startDate, order: .reverse), SortDescriptor(\Habits.startDate, order: .forward), SortDescriptor(\Habits.name, order: .reverse), SortDescriptor(\Habits.name, order: .forward)]) var habits: [Habits]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 7) {
            ForEach(habits) { habits in
                NavigationLink {
                    EditHabit(habit: habits)
                } label: {
                    CardView(habit: habits)
                }
            }
        }
    }
    
    init(sort: SortDescriptor<Habits>) {
        _habits = Query(sort: [sort])
    }
>>>>>>> FormLayout
}
