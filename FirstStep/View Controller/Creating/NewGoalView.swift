//
//  NewGoalView.swift
//  FirstStep
//
//  Created by JaredMurray on 5/14/24.
//

import SwiftData
import SwiftUI
import PhotosUI

struct NewGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var goalImage = Goals().image
    @State private var image: Image?
    @State private var goalName = ""
    @State private var startDate: Date = .now
    @State private var showAlert = false
    @State var color = Color.red
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            Spacer(minLength: 200)
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 45)
                        .fill(color)
                        .frame(width: 375, height: 225)
                    
                    image?
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 375, maxHeight: 225)
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                }
                .overlay(alignment: .bottomLeading) {
                    
                    VStack {
                        Text("0")
                            .font(.headline)
                            .foregroundStyle(color.adaptedTextColor())
                        
                        Text("Days")
                            .font(.subheadline)
                            .foregroundStyle(color.adaptedTextColor())
                            .frame(width: 100)
                            .padding(.bottom, 20)
                    }
                    
                }
                
                if image != nil {
                    Button("Reset Image") {
                        withAnimation {
                            image = nil
                            selectedPhoto = nil
                            goalImage = nil
                        }
                    }
                    .foregroundStyle(.red)
                }
                
                Spacer(minLength: 20)
                
                GroupBox {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("", text: $goalName, prompt: Text("e.g. No Sugar").foregroundStyle(.secondary))
                        
                        DatePicker("Start Date:", selection: $startDate)
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
                }
            }
            .padding(.bottom, 250)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        guard goalName.isEmpty == false else {
                            self.showAlert = true
                            return
                        }
                        createGoal()
                        dismiss()
                    }
                }
            }
            .alert("Please enter a habit", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    goalImage = data
                    loadImage()
                }
            }
        }
    }
    
    func loadImage() {
        guard let goalImage = goalImage else { return }
        guard let uiImage = UIImage(data: goalImage) else { return }
        image = Image(uiImage: uiImage)
    }
    
    func createGoal() {
        if image != nil {
            let cardColor = color.hexString()
            let newGoal = Goals(name: goalName, startDate: startDate, cardColor: cardColor, image: goalImage)
            modelContext.insert(newGoal)
        } else {
            let cardColor = color.hexString()
            let newGoal = Goals(name: goalName, startDate: startDate, cardColor: cardColor)
            modelContext.insert(newGoal)
        }
    }
}
