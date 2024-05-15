//
//  TabView.swift
//  FirstStep
//
//  Created by JaredMurray on 5/14/24.
//

import SwiftUI
import Combine

enum tabSelection: String {
    case habits, goals
}

struct TabBarView: View {
    @Environment(\.modelContext) var modelContext
    @State private var habitSortOrder = SortDescriptor(\Habits.startDate)
    @State private var goalSortOrder = SortDescriptor(\Goals.startDate)
    
    @State private var showingEditHabit = false
    @State private var showingEditGoals = false
    
    @State var tab = tabSelection.habits
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tab) {
                HabitSortView(sortHabit: habitSortOrder, tab: $tab)
                    .tabItem {
                        Label("Habits", systemImage: "tray.and.arrow.down.fill")
                    }
                    .tag(tabSelection.habits)
                
                HabitSortView(sortGoals: goalSortOrder, tab: $tab)
                    .tabItem {
                        Label("Goals", systemImage: "house.fill")
                    }
                    .tag(tabSelection.goals)
                
            }
            .toolbar {
                Button("", systemImage: "plus") {
                    if tab == .habits {
                        showingEditHabit.toggle()
                    } else {
                        showingEditGoals.toggle()
                    }
                }
                switch tab {
                case .habits:
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $habitSortOrder) {
                            Text("Name: A To Z")
                                .tag(SortDescriptor(\Habits.name, order: .forward))
                            
                            Text("Name: Z To A")
                                .tag(SortDescriptor(\Habits.name, order: .reverse))
                            
                            Text("Date: New To Old")
                                .tag(SortDescriptor(\Habits.startDate, order: .reverse))
                            
                            Text("Date: Old To New")
                                .tag(SortDescriptor(\Habits.startDate, order: .forward))
                        }
                        .pickerStyle(.inline)
                    }
                case .goals:
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $goalSortOrder) {
                            Text("Name: A To Z")
                                .tag(SortDescriptor(\Goals.name, order: .forward))
                            
                            Text("Name: Z To A")
                                .tag(SortDescriptor(\Goals.name, order: .reverse))
                            
                            Text("Date: New To Old")
                                .tag(SortDescriptor(\Goals.startDate, order: .reverse))
                            
                            Text("Date: Old To New")
                                .tag(SortDescriptor(\Goals.startDate, order: .forward))
                        }
                        .pickerStyle(.inline)
                    }
                }
            }
            .sheet(isPresented: tab == .habits ? $showingEditHabit: $showingEditGoals) {
                switch tab {
                case .habits:
                    NewHabitView()
                case .goals:
                    NewGoalView()
                }
            }
            .navigationTitle(tab.rawValue.capitalized)
        }
    }
}

#Preview {
    TabBarView()
}
