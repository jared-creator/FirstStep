//
//  EditHabit.swift
//  FirstStep
//
//  Created by JaredMurray on 4/25/24.
//

import SwiftData
import SwiftUI
import PhotosUI

struct EditHabit: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var habit: Habits
    @State private var image: Image?
    @State private var showAlert = false
    @State private var color = Color.red
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var streak: DateComponents = DateComponents()
    
    var body: some View {
        Spacer(minLength: 200)
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
            
            Spacer(minLength: 20)
            
            GroupBox {
                VStack(alignment: .leading, spacing: 10) {
                    TextField("", text: $habit.name, prompt: Text("e.g. No Sugar")
                        .foregroundStyle(.secondary))
                    
                    DatePicker("Start Date:", selection: $habit.startDate)
                        .foregroundStyle(.secondary)
                    
                    ColorPicker("Pick a Color", selection: $color)
                        .foregroundStyle(.secondary)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Need more motivation, add a photo")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            
                            Text("Optional")
                                .font(.caption2)
                                .foregroundStyle(.secondary.opacity(0.5))
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                            Image(systemName: "photo")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 10)
                .padding(.trailing, 5)
            }
            
            Spacer(minLength: 50)
            
            Button {
                deleteHabit()
                dismiss()
                
            } label: {
                Text("Delete Habit")
                    .frame(maxWidth: 250)
            }
            .tint(.red)
            .controlSize(.extraLarge)
            .buttonStyle(BorderedProminentButtonStyle())
            .buttonBorderShape(.roundedRectangle(radius: 20))
        }
        .padding(.bottom, 250)
        .alert("Please enter a habit", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear {
            streak = streak.streakTime(habit: habit.startDate)
            color = Color(hex: habit.cardColor) ?? .red
            loadImage()
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                habit.image = data
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
    
    func deleteHabit() {
        modelContext.delete(habit)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        let example = Habits(name: "No Popcorn", startDate: .now, cardColor: "#FD3A69")
        return EditHabit(habit: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
