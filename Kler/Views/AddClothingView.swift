//
//  AddClothingView.swift
//  Kler
//
//  Created by Catalina on 11/18/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddClothingView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let category: String

    @State private var name = ""
    @State private var color = ""
    @State private var notes = ""
    @State private var selectedUIImage: UIImage?
    @State private var selectedDate = Date()
    @State private var usesThisMonth = 1
    @State private var showingPicker = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("New Clothing")
                    .font(.largeTitle.bold())

                VStack(alignment: .leading, spacing: 10) {
                    Text("Photo")
                        .font(.headline)

                    Button {
                        showingPicker = true
                    } label: {
                        HStack {
                            Image(systemName: "photo")
                                .font(.title3)
                                .foregroundColor(.blue)
                            Text("Choose Image")
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(14)
                    }

                    if let ui = selectedUIImage {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .cornerRadius(12)
                            .padding(.top, 4)
                    }
                }
                VStack(alignment: .leading, spacing: 16) {

                    Text("Details")
                        .font(.headline)

                    Group {
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)

                        TextField("Color", text: $color)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)

                        TextField("Notes", text: $notes)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)

                        
                        TextField("Category", text: .constant(category))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .disabled(true)
                    }
                    DatePicker("Last Worn", selection: $selectedDate, displayedComponents: .date)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)

                    Stepper("Uses this month: \(usesThisMonth)",
                            value: $usesThisMonth,
                            in: 1...50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                }

                VStack(spacing: 14) {
                    Button {
                        saveItem(donate: false)
                    } label: {
                        Text("Add Item")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button {
                        saveItem(donate: true)
                    } label: {
                        Text("Add & Donate")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 8)

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .sheet(isPresented: $showingPicker) {
            ImagePicker(image: $selectedUIImage)
        }
    }

    private func saveItem(donate: Bool) {
        let data = selectedUIImage?.jpegData(compressionQuality: 0.85)

        var lat: Double? = nil
        var lon: Double? = nil

        if let loc = LocationManager.shared.currentLocation {
            lat = loc.coordinate.latitude
            lon = loc.coordinate.longitude
        }

        let item = ClothingItem(
            name: name,
            category: category,
            color: color,
            notes: notes,
            imageData: data,
            lastWorn: selectedDate,
            usesThisMonth: usesThisMonth,
            isListed: donate,
            donated: donate,
            listingLatitude: lat,
            listingLongitude: lon
        )

        context.insert(item)
        dismiss()
    }
}

#Preview {
    AddClothingView(category: "Tops")
        .modelContainer(for: ClothingItem.self, inMemory: true)
}
