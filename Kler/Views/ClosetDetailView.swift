//
//  ClosetDetailView.swift
//  Kler
//
//  Created by Catalina on 11/16/25.
//

import SwiftUI
import SwiftData
import CoreLocation

struct ClosetDetailView: View {
    @Bindable var item: ClothingItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {

                if let data = item.imageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                }

                Text(item.name)
                    .font(.title2)
                    .bold()
                
                Text("Color: \(item.color)")
                
                Text(item.notes.isEmpty ? "No notes" : item.notes)

                if let last = item.lastWorn {
                    Text("Last worn: \(last.formatted(date: .abbreviated, time: .omitted))")
                }

                Stepper("Worn this month: \(item.usesThisMonth)",
                        value: $item.usesThisMonth,
                        in: 0...31)

                SustainabilityBadge(level: item.sustainabilityLevel)

                Divider()

                Button(item.isListed ? "Remove from listings" : "List for sale") {
                    item.isListed.toggle()

                    if item.isListed {
                        if let loc = LocationManager.shared.currentLocation {
                            item.listingLatitude = loc.coordinate.latitude
                            item.listingLongitude = loc.coordinate.longitude
                        }
                    } else {
                        item.listingLatitude = nil
                        item.listingLongitude = nil
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(item.isListed ? .red : .blue)
            }
            .padding()
        }
        .onAppear {
            print("ClosetDetailView appeared for item: \(item.name)")
        }
        .navigationTitle("Details")
    }
}

