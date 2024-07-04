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
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // this gives the most accurate location of the user
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //We want to return soon as we get the users location.
        guard !locations.isEmpty else {return}
        
        locationManager.stopUpdatingLocation()
    }
}
