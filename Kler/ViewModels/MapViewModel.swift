//
//  MapViewModel.swift
//  Kler
//
//  Created by Catalina on 11/18/25.
//

import Foundation
import Combine
import MapKit
import SwiftData
import CoreLocation

@MainActor
class MapViewModel: ObservableObject {

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.335, longitude: -71.170),
        span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    )

    var staticLocations: [KlerLocation] = [

        KlerLocation(
            title: "Goodwill Downtown",
            coordinate: CLLocationCoordinate2D(latitude: 42.350, longitude: -71.083),
            type: .goodwill,
            address: "965 Commonwealth Ave, Boston",
            hours: "9am–7pm",
            imageName: "mock_goodwill"
        ),

        KlerLocation(
            title: "Textile Recycling Center",
            coordinate: CLLocationCoordinate2D(latitude: 42.342, longitude: -71.121),
            type: .recycle,
            address: "45 Greenway Ave",
            hours: "Everyday 9–8",
            imageName: "mock_recycle"
        )
    ]

    func userListings(from items: [ClothingItem]) -> [KlerLocation] {

        let listedItems = items.filter { $0.isListed }

        return
            listedItems.enumerated().map { index, item in

            let offset = Double(index) * 0.002

            return KlerLocation(
                title: item.name,
                coordinate: CLLocationCoordinate2D(
                    latitude: region.center.latitude + offset,
                    longitude: region.center.longitude - offset
                ),
                type: .userListing,
                address: "Near your location",
                hours: "Seller via app",
                imageName: nil
            )
        }
    }

    func zoom(factor: Double) {
        region.span.latitudeDelta *= factor
        region.span.longitudeDelta *= factor
    }
}


