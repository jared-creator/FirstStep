//
//  ContentView.swift
//  FirstStep
//
//  Created by JaredMurray on 4/17/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Habits.startDate)
    
    @State private var showingDetail = false
    
    var body: some View {
        NavigationStack {
            TabView {
                ScrollView {
                    HabitSortView(sort: sortOrder)
                        .navigationTitle("Habits")
                        .toolbar {
                            Button("", systemImage: "plus") {
                                showingDetail.toggle()
                            }
                            
                            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                                Picker("Sort", selection: $sortOrder) {
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
                        }
                        .sheet(isPresented: $showingDetail, content: {
                            NewHabitView()
                        })
                }
                .tabItem {
                    Label("Bad Habits", systemImage: "tray.and.arrow.down.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
