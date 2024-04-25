//
//  CardView.swift
//  FirstStep
//
//  Created by JaredMurray on 4/19/24.
//

import SwiftUI

struct CardView: View {
    var habit: Habits
    @State private var image: Image?
    @State private var loadPhoto: Image?
    @State private var color = Color.red
    @State private var streak: DateComponents = DateComponents()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let habits = Habits()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 45)
                    .fill(color)
                    .frame(width: 187.5, height: 112.5)
                    .shadow(color: .black, radius: 2)
                
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 187.5, maxHeight: 112.5)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
            }
            .overlay(alignment: .bottomLeading) {
                
                if streak.day != 0 {
                    VStack {
                        Text("\(streak.day ?? 0)")
                            .font(.headline)
                            .foregroundStyle(color.adaptedTextColor())
                        
                        Text("Day(s)")
                            .font(.subheadline)
                            .foregroundStyle(color.adaptedTextColor())
                            .frame(width: 100)
                            .padding(.bottom, 20)
                    }
                    
                } else {
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(streak.hour ?? 0)")
                                .font(.headline)
                                .foregroundStyle(color.adaptedTextColor())
                            
                            Text("Hour(s)")
                                .font(.subheadline)
                                .foregroundStyle(color.adaptedTextColor())
                                .padding(.bottom, 20)
                        }
                        VStack {
                            Text("\(streak.minute ?? 0)")
                                .font(.headline)
                                .foregroundStyle(color.adaptedTextColor())
                            
                            Text("Minute(s)")
                                .font(.subheadline)
                                .foregroundStyle(color.adaptedTextColor())
                                .padding(.bottom, 20)
                        }
                    }
                    .padding(.leading, 30)
                }
            }
            Text(habit.name)
        }
        .task {
            loadImage()
        }
        .onAppear {
            streak = habits.streakTime(habit: habit.startDate)
            color = Color(hex: habit.cardColor) ?? .black
            
        }
        .onReceive(timer) { _ in
            streak = habits.streakTime(habit: habit.startDate)
        }
    }
    
    func loadImage() {
        guard habit.image != nil else { return }
        let uiImage = UIImage(data: habit.image!)!
        image = Image(uiImage: uiImage)
    }
}
