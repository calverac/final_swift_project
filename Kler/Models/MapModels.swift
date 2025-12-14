//
//  MapModels.swift
//  Kler
//
//  Created by Catalina on 11/18/25.
//

import Foundation
import MapKit

enum LocationType {
   case goodwill
   case recycle
   case userListing
}


struct KlerLocation: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    let type: LocationType
    let address: String
    let hours: String
    let imageName: String?
}
