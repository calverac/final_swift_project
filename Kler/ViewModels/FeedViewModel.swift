//
//  FeedViewModel.swift
//  Kler
//
//  Created by Catalina on 12/6/25.
//

import Foundation
import CoreLocation
import Combine

struct FeedPost: Identifiable {
    let id = UUID()
    let username: String
    let title: String
    let description: String
    let imageName: String
    let coordinate: CLLocationCoordinate2D
}

class FeedViewModel: ObservableObject {

    private var lastTips: [String] = []
    @Published var currentTips: [String] = []

    let sustainabilityTips: [String] = [
        "Wash clothes in cold water to save energy.",
        "Air-dry instead of tumble drying.",
        "Repair small rips instead of tossing items.",
        "Donate or resell pieces you rarely wear.",
        "Buy fewer, high-quality basics.",
        "Use a wash bag for delicates.",
        "Track how often you wear each item.",
        "Host clothing swaps with friends.",
        "Buy second-hand when possible.",
        "Avoid washing denim too often.",
        "Use gentle detergents.",
        "Plan outfits weekly."
    ]

    let communityPosts: [FeedPost] = [
        FeedPost(
            username: "@lucas.thrift",
            title: "Vintage Levi’s 501",
            description: "Size 28, gently worn, looking for a new home.",
            imageName: "mock_jeans",
            coordinate: .init(latitude: 42.3496, longitude: -71.0826)
        ),
        FeedPost(
            username: "@maria.vintage",
            title: "Chunky Knit Sweater",
            description: "Perfect for Boston winters ❄️",
            imageName: "mock_sweater",
            coordinate: .init(latitude: 42.3429, longitude: -71.1003)
        ),
        FeedPost(
            username: "@josh.rewear",
            title: "Nike Air Force 1",
            description: "Still super clean, size 9.",
            imageName: "mock_sneakers",
            coordinate: .init(latitude: 42.3736, longitude: -71.1190)
        )
    ]

    init() {
        generateNewTips()
    }

    func generateNewTips() {
        var new = Array(sustainabilityTips.shuffled().prefix(2))
        while new == lastTips {
            new = Array(sustainabilityTips.shuffled().prefix(2))
        }
        lastTips = new
        currentTips = new
    }
}



