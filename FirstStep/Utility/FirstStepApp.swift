//
//  FirstStepApp.swift
//  FirstStep
//
//  Created by JaredMurray on 4/17/24.
//

import SwiftData
import SwiftUI

@main
struct FirstStepApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habits.self)
    }
}
