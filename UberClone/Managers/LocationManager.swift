//
//  LocationManager.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//


//WE CAN'T ASK THE USER FOR THEIR CURRENT LOCATION THROUGH THE MAPVIEW FRAMEWORK
// WE HAVE TO USE THIS LOCATION MANAGER. 

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
