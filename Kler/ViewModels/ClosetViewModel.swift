//
//  ClosetViewModel.swift
//  Kler
//
//  Created by Catalina on 11/16/25.
//

import Foundation
import Combine

@MainActor
class ClosetViewModel: ObservableObject {
    @Published var categories: [String] = [
        "Tops", "Sweaters", "Pants",
        "Dresses", "Shoes", "Accessories"
    ]
    
    func addCategory(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !categories.contains(trimmed) else { return }
        categories.append(trimmed)
    }
    func removeCategory(_ name: String) {
        categories.removeAll { $0 == name }
    }
}
