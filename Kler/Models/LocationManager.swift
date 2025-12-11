//
//  LocationManager.swift
//  Kler
//
//  Created by Catalina on 12/8/25.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    static let shared = LocationManager()

    private let manager = CLLocationManager()
    @Published var currentLocation: CLLocation?

    override private init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }
}
