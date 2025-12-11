//
//  ClothingItem.swift
//  Kler
//
//  Created by Catalina on 12/6/25.
//

import Foundation
import SwiftData

@Model
class ClothingItem {
    var id: UUID
    var name: String
    var category: String
    var color: String
    var notes: String

    var imageData: Data?
    var assetImageName: String?

    var lastWorn: Date?
    var usesThisMonth: Int

    var isListed: Bool
    var donated: Bool
    var listingLatitude: Double?
    var listingLongitude: Double?

    init(
        name: String,
        category: String,
        color: String,
        notes: String,
        imageData: Data?,
        lastWorn: Date?,
        usesThisMonth: Int,
        isListed: Bool = false,
        donated: Bool = false,
        listingLatitude: Double? = nil,
        listingLongitude: Double? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.color = color
        self.notes = notes
        self.imageData = imageData
        self.assetImageName = nil
        self.lastWorn = lastWorn
        self.usesThisMonth = usesThisMonth
        self.isListed = isListed
        self.donated = donated
        self.listingLatitude = listingLatitude
        self.listingLongitude = listingLongitude
    }

    init(
        name: String,
        category: String,
        color: String,
        notes: String,
        imageName: String
    ) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.color = color
        self.notes = notes
        self.imageData = nil
        self.assetImageName = imageName
        self.lastWorn = Date()
        self.usesThisMonth = Int.random(in: 1...5)
        self.isListed = false
        self.donated = false
        self.listingLatitude = nil
        self.listingLongitude = nil
    }

    var sustainabilityLevel: SustainabilityLevel {
        if usesThisMonth >= 5 { return .green }
        if usesThisMonth >= 1 { return .yellow }
        return .red
    }

    var sustainabilityScore: Int {
        usesThisMonth * 10
    }
}
