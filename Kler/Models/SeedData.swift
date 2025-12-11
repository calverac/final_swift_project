//
//  SeedData.swift
//  Kler
//
//  Created by Catalina on 12/8/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
struct SeedData {

    static func seedIfNeeded(context: ModelContext) {

        let request = FetchDescriptor<ClothingItem>()
        let existing = (try? context.fetch(request)) ?? []
        guard existing.isEmpty else { return }

        let samples: [ClothingItem] = [
            ClothingItem(
                name: "Black Coat",
                category: "Coats",
                color: "Black",
                notes: "",
                imageName: "mock_coat",
            ),

            ClothingItem(
                name: "Summer Dress",
                category: "Dresses",
                color: "Yellow",
                notes: "",
                imageName: "mock_dress"
            ),

            ClothingItem(
                name: "Heels",
                category: "Shoes",
                color: "Beige",
                notes: "",
                imageName: "mock_heels"
            ),

            ClothingItem(
                name: "Hoodie",
                category: "Sweaters",
                color: "Gray",
                notes: "",
                imageName: "mock_hoodie"
            ),

            ClothingItem(
                name: "Jacket",
                category: "Coats",
                color: "Brown",
                notes: "",
                imageName: "mock_jacket"
            ),

            ClothingItem(
                name: "Jeans",
                category: "Pants",
                color: "Blue",
                notes: "",
                imageName: "mock_jeans"
            ),

            ClothingItem(
                name: "Sneakers",
                category: "Shoes",
                color: "White",
                notes: "",
                imageName: "mock_sneakers"
            ),

            ClothingItem(
                name: "Basic Tee",
                category: "Tops",
                color: "White",
                notes: "",
                imageName: "mock_tee"
            )
        ]

        for item in samples {
            context.insert(item)
        }
    }
}

