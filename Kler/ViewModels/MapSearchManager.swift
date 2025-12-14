//
//  MapSearchManager.swift
//  Kler
//
//  Created by Catalina on 11/20/25.
//

import Foundation
import MapKit
import Combine

@MainActor
class MapSearchManager: ObservableObject {

    static let shared = MapSearchManager()

    @Published var donationResults: [MKMapItem] = []

    func searchDonationCenters(near coordinate: CLLocationCoordinate2D) async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "clothing donation"
        request.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.12,
                                   longitudeDelta: 0.12)
        )

        let search = MKLocalSearch(request: request)

        do {
            let response = try await search.start()
            donationResults = response.mapItems
        } catch {
            print("Map search failed: \(error)")
        }
    }
}
