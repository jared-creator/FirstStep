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
    @Query var habits: [Habits]
    
    @State private var showingDetail = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(habits) { habits in
                        NavigationLink {
                            EditHabit(habit: habits)
                        } label: {
                            CardView(habit: habits)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Habits")
                            .font(.title)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingDetail.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Delete", action: deleteAll)
                    }
                }
                .sheet(isPresented: $showingDetail, content: {
                    NewHabitView()
                })
            }
        }
    }
    
    func deleteHabits(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContext.delete(habit)
        }
    }
    
    func deleteAll() {
        for i in 0..<habits.count {
            modelContext.delete(habits[i])
        }
    }
}

#Preview {
    ContentView()
}
