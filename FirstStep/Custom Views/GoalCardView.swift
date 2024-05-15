//
//  GoalCardView.swift
//  FirstStep
//
//  Created by JaredMurray on 5/14/24.
//

import SwiftUI

struct GoalCardView: View {
    var goal: Goals
    @State private var image: Image?
    @State private var color = Color.red
    @State private var streak: DateComponents = DateComponents()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 45)
                    .fill(Color(hex: goal.cardColor)!)
                    .stroke(.gray, lineWidth: 0.5)
                    .frame(width: 187.5, height: 112.5)
                
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
                    HStack {
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
            Text(goal.name)
        }
        .task {
            loadImage()
        }
        .onAppear {
            streak = streak.streakTime(habit: goal.startDate)
            color = Color(hex: goal.cardColor) ?? .black
            
        }
        .onReceive(timer) { _ in
            streak = streak.streakTime(habit: goal.startDate)
        }
    }
    
    func loadImage() {
        guard goal.image != nil else {
            image = nil
            return
        }
        let uiImage = UIImage(data: goal.image!)!
        image = Image(uiImage: uiImage)
    }
}
