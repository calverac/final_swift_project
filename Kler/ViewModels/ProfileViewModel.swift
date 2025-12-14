//
//  ProfileViewModel.swift
//  Kler
//
//  Created by Catalina on 11/6/25.
//

import Foundation

struct ProfileViewModel {

    func topUsed(items: [ClothingItem], limit: Int = 5) -> [ClothingItem] {
        Array(items.sorted { $0.usesThisMonth > $1.usesThisMonth }.prefix(limit))
    }

    func leastUsed(items: [ClothingItem], limit: Int = 5) -> [ClothingItem] {
        Array(items.sorted { $0.usesThisMonth < $1.usesThisMonth }.prefix(limit))
    }

    func listed(items: [ClothingItem], limit: Int = 5) -> [ClothingItem] {
        Array(items.filter { $0.isListed }.prefix(limit))
    }
}

