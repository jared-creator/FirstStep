//
//  EditHabit.swift
//  FirstStep
//
//  Created by JaredMurray on 4/25/24.
//

import SwiftUI
import PhotosUI

struct EditHabit: View {
    @State var habit: Habits
    @State private var image: Image?
    @State private var habitName = ""
    @State private var startDate: Date = .now
    @State private var showAlert = false
    @State var color = Color.red
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var streak: DateComponents = DateComponents()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 45)
                    .fill(Color(hex: habit.cardColor)!)
                    .stroke(.gray, lineWidth: 0.5)
                    .frame(width: 375, height: 225)
                
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 375, maxHeight: 225)
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
            
            if image != nil {
                Button("Reset Image") {
                    withAnimation {
                        image = nil
                        selectedPhoto = nil
                        habit.image = nil
                    }
                }
                .foregroundStyle(.red)
            }
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.thinMaterial)
                .frame(width: 375, height: 190)
                .overlay {
                    VStack(spacing: 17) {
                        TextField("", text: $habit.name, prompt: Text("e.g. No Sugar").foregroundStyle(.secondary))
                        HStack {
                            Text("Start Date: ")
                                .foregroundStyle(.secondary)
                            
                            DatePicker("", selection: $habit.startDate)
                        }
                        
                        ColorPicker("Pick a Color", selection: $color)
                            .foregroundStyle(.secondary)
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Need more motivation, add a photo")
                                    .fixedSize()
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                Text("Optional")
                                    .fixedSize()
                                    .font(.caption2)
                                    .foregroundStyle(.secondary.opacity(0.5))
                            }
                            .padding(.trailing, 120)
                            
                            
                            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                                Label("Add Image", systemImage: "photo")
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 15)
                }
        }
        .padding(.bottom, 250)
        .alert("Please enter a habit", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear {
            streak = habit.streakTime(habit: habit.startDate)
            color = Color(hex: habit.cardColor) ?? .red
            loadImage()
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                loadImage()
            }
        }
        .task(id: color) {
            habit.cardColor = color.hexString()
        }
    }
    
    func loadImage() {
        guard let habitImage = habit.image else { return }
        guard let uiImage = UIImage(data: habitImage) else { return }
        image = Image(uiImage: uiImage)
    }
    
}
