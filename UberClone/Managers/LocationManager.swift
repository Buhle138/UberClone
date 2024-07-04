//
//  LocationManager.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import CoreLocation


class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    override init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // this gives the most accurate location of the user
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}
